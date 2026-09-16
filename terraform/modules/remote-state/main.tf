locals {
  name_prefix = "${var.project_name}-${var.environment}"

  state_bucket_name = coalesce(
    var.state_bucket_name,
    "${local.name_prefix}-tfstate-${var.aws_region}"
  )

  lock_table_name = coalesce(
    var.lock_table_name,
    "${local.name_prefix}-tf-locks"
  )

  mandatory_tags = {
    project     = var.project_name
    environment = var.environment
    owner       = var.owner
    managed_by  = "terraform"
  }

  tags = merge(local.mandatory_tags, var.tags)
}

resource "aws_s3_bucket" "state" {
  # checkov:skip=CKV_AWS_18: Access logging needs a separate log bucket; deferred to hardening backlog
  # checkov:skip=CKV_AWS_144: Cross-region replication is optional for demo state backends
  # checkov:skip=CKV_AWS_145: AES256 SSE is the documented baseline; CMK optional for regulated tenants
  # checkov:skip=CKV2_AWS_62: Event notifications not required for Terraform state
  bucket        = local.state_bucket_name
  force_destroy = var.force_destroy

  tags = merge(local.tags, {
    Name = local.state_bucket_name
  })
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

data "aws_iam_policy_document" "state_bucket" {
  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:*"]

    resources = [
      aws_s3_bucket.state.arn,
      "${aws_s3_bucket.state.arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "state" {
  bucket = aws_s3_bucket.state.id
  policy = data.aws_iam_policy_document.state_bucket.json
}

resource "aws_s3_bucket_lifecycle_configuration" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    id     = "expire-noncurrent-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_dynamodb_table" "locks" {
  # checkov:skip=CKV_AWS_119: AWS-owned encryption is sufficient for state lock metadata
  name         = local.lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(local.tags, {
    Name = local.lock_table_name
  })
}
