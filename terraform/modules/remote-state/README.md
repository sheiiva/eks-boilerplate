# Module: remote-state

Bootstrap remote state backend (S3 + DynamoDB lock, or successor equivalent).

**Status:** scaffold (implementation in **P1**)

## Planned inputs

- `project_name`, `environment`, `aws_region`
- Bucket naming / encryption settings

## Planned outputs

- `state_bucket_name`, `lock_table_name`, backend config snippets for compositions
