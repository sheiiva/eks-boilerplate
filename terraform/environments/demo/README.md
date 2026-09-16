# Environment: demo

Composition: network + EKS + Karpenter (P3).

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

After apply:

```bash
aws eks update-kubeconfig --region <region> --name <cluster_name>
kubectl get nodes
kubectl get nodepools -A
```

Platform add-ons (ALB, External Secrets) land in P4.
