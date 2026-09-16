# Terraform Structure

Reusable modules and environment compositions for the EKS landing zone.

## Layout

- `bootstrap/` — one-time remote state (S3 + DynamoDB lock) with local state
- `modules/remote-state/` — state bucket + lock table
- `modules/network/` — VPC and networking baseline
- `modules/eks/` — EKS control plane and IRSA/OIDC
- `modules/karpenter/` — Karpenter controller and NodePool defaults
- `modules/addons/` — ALB Controller, External-DNS, External-Secrets (P4)
- `environments/demo/` — reference composition (network + EKS + Karpenter)

## Notes

- Terraform version target: `>= 1.6`
- Copy `*.tfvars.example` → `terraform.tfvars` and `backend.hcl.example` → `backend.hcl` locally (gitignored)
- Module details: `docs/module-map.md`
