# Production-Ready EKS Boilerplate

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![Terraform Validate](https://github.com/sheiiva/eks-boilerplate/actions/workflows/terraform-validate.yml/badge.svg)](https://github.com/sheiiva/eks-boilerplate/actions/workflows/terraform-validate.yml)

## Business Value

Reusable AWS EKS landing zone accelerator: private networking, managed control plane, Karpenter elasticity, and platform controllers (ALB, External Secrets, optional ExternalDNS) — onboard by configuration, not by rewriting modules.

## What v1 demonstrates

1. **Template-first IaC** — modules + `environments/demo` composition  
2. **Remote state bootstrap** — S3 + DynamoDB lock  
3. **Private VPC** — NAT, optional endpoints, ALB/Karpenter subnet tags  
4. **EKS** — OIDC/IRSA, KMS secrets encryption, access entries, bootstrap node group  
5. **Karpenter** — IRSA controller, interruption queue, default NodePool  
6. **Add-ons** — AWS Load Balancer Controller + External Secrets (ExternalDNS optional)  
7. **CI** — `terraform fmt` + `validate` on every change  

Live AWS apply is **optional** and costs money — see [cost guardrails](./docs/runbooks/cost-guardrails.md). Portfolio proof is validated Terraform + architecture docs.

## Quick start (no AWS spend)

```bash
git clone https://github.com/sheiiva/eks-boilerplate.git
cd eks-boilerplate
for d in terraform/modules/* terraform/bootstrap terraform/environments/demo; do
  terraform -chdir="$d" init -backend=false -input=false
  terraform -chdir="$d" validate
done
```

## Apply path (ephemeral demo)

1. [`terraform/bootstrap`](./terraform/bootstrap/README.md) — create state backend  
2. [`terraform/environments/demo`](./terraform/environments/demo/README.md) — network + EKS + Karpenter + add-ons  
3. Destroy when done — [`docs/runbooks/destroy.md`](./docs/runbooks/destroy.md)

## Directory layout

- `terraform/modules/` — remote-state, network, eks, karpenter, addons  
- `terraform/bootstrap/` — one-time state backend  
- `terraform/environments/demo/` — reference composition  
- `examples/` — Ingress + ExternalSecret samples  
- `docs/` — architecture, roadmap, runbooks  

## Delivery docs

- [Architecture](./docs/architecture.md)  
- [Module map](./docs/module-map.md)  
- [Config model](./docs/config-model.md)  
- [Roadmap](./docs/roadmap.md)  
- [Project board](https://github.com/users/sheiiva/projects/7) — milestones, Done vs Todo  
- [Bootstrap runbook](./docs/runbooks/bootstrap.md)  
- [API access lockdown](./docs/runbooks/api-access.md)  
- [Cost guardrails](./docs/runbooks/cost-guardrails.md)  

## Current status

**v1 complete (P0–P5)** — landing zone modules, demo composition, CI validate, operator runbooks.  

**Next (v1.1 / v2):** tracked on the [project board](https://github.com/users/sheiiva/projects/7) under milestones P6–P8 (API lockdown, policy scan, observability, optional GitOps).
