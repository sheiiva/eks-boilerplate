# Environment: demo

Reference composition for the EKS landing zone (P1: network foundation).

## Prerequisites

1. Apply remote state bootstrap once: `terraform/bootstrap/`
2. Copy examples and fill real backend values:

```bash
cp terraform.tfvars.example terraform.tfvars
cp backend.hcl.example backend.hcl
# edit backend.hcl from bootstrap outputs
```

## Commands

```bash
terraform init -backend-config=backend.hcl
terraform plan
terraform apply
```

For local validation without a remote backend, temporarily comment the `backend "s3" {}` block or use:

```bash
terraform init -backend=false
terraform validate
```

EKS / Karpenter / add-ons modules are wired in later milestones (P2–P4).
