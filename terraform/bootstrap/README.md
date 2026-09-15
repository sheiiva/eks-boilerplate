# Remote state bootstrap

One-time apply (local state) that creates the S3 bucket + DynamoDB lock table used by environment compositions.

```bash
cd terraform/bootstrap
cp terraform.tfvars.example terraform.tfvars   # edit bucket name if needed
terraform init
terraform plan
terraform apply
```

Copy `backend_config` output values into `environments/demo/backend.hcl` (from the example), then migrate demo state:

```bash
cd ../environments/demo
terraform init -backend-config=backend.hcl
```
