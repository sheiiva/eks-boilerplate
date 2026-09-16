# Environment: demo

Full landing-zone composition: network → EKS → Karpenter → platform add-ons.

## Cost warning

Live `apply` incurs AWS charges (NAT, EKS control plane ~$0.10/hr, nodes, optional endpoints). Prefer `validate` / short-lived apply + `destroy` for demos. See `docs/runbooks/cost-guardrails.md`.

## Prerequisites

1. Apply remote state bootstrap once: `terraform/bootstrap/`
2. Copy examples:

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

Local validation without remote backend / AWS account:

```bash
terraform init -backend=false
terraform validate
```

## After apply

```bash
aws eks update-kubeconfig --region <region> --name <cluster_name>
kubectl get nodes
kubectl get nodepools -A
```
