# Module: remote-state

Bootstrap remote Terraform state: encrypted versioned S3 bucket + DynamoDB lock table.

**Status:** implemented (P1)

## Usage

Apply once per account/region with a **local** backend (see `terraform/bootstrap/`), then point environment compositions at the outputs.

```hcl
module "remote_state" {
  source = "../modules/remote-state"

  project_name = "eks-lz"
  environment  = "demo"
  owner        = "platform"
  aws_region   = "eu-west-1"
}
```

## Notes

- Bucket names must be globally unique; override `state_bucket_name` if the derived name collides.
- `force_destroy` defaults to `false`; enable only for disposable demos.
- Prefer TLS-only access (enforced by bucket policy).
