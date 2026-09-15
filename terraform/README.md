# Terraform Structure

Reusable modules and environment compositions for the EKS landing zone.

## Layout

- `modules/remote-state/` — state bucket + lock (bootstrap)
- `modules/network/` — VPC and networking baseline
- `modules/eks/` — EKS control plane and IRSA/OIDC
- `modules/karpenter/` — Karpenter controller and NodePool defaults
- `modules/addons/` — ALB Controller, External-DNS, External-Secrets
- `environments/demo/` — reference composition

## Notes

- Terraform version target: `>= 1.6`
- Modules are scaffolded in P0, then implemented through milestone issues (see `docs/module-map.md` and `docs/roadmap.md`)
- Do not commit state files, kubeconfig, or secret tfvars
