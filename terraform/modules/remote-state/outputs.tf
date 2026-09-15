output "state_bucket_name" {
  description = "S3 bucket name for Terraform state."
  value       = aws_s3_bucket.state.id
}

output "state_bucket_arn" {
  description = "S3 bucket ARN for Terraform state."
  value       = aws_s3_bucket.state.arn
}

output "lock_table_name" {
  description = "DynamoDB table name used for state locking."
  value       = aws_dynamodb_table.locks.name
}

output "backend_config" {
  description = "Values to paste into a Terraform S3 backend block."
  value = {
    bucket         = aws_s3_bucket.state.id
    dynamodb_table = aws_dynamodb_table.locks.name
    region         = var.aws_region
    encrypt        = true
  }
}
