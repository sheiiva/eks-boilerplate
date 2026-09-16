# Environment: demo

Composition: network + EKS control plane (P2).

## Prerequisites

1. Apply remote state bootstrap once: `terraform/bootstrap/`
2. Copy examples:

```bash
cp terraform.tfvars.example terraform.tfvars
cp backend.hcl.example backend.hcl
```

## Commands

```bash
terraform init -backend-config=backend.hcl
terraform plan
terraform apply
```

Local validation without remote backend:

```bash
terraform init -backend=false
terraform validate
```

Karpenter and platform add-ons land in later milestones (P3–P4).
