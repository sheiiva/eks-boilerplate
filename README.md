# Production-Ready EKS Boilerplate

[![Release](https://img.shields.io/github/v/release/sheiiva/eks-boilerplate?display_name=tag&sort=semver)](https://github.com/sheiiva/eks-boilerplate/releases/latest)
[![Terraform Validate](https://github.com/sheiiva/eks-boilerplate/actions/workflows/terraform-validate.yml/badge.svg)](https://github.com/sheiiva/eks-boilerplate/actions/workflows/terraform-validate.yml)
[![Policy Scan](https://github.com/sheiiva/eks-boilerplate/actions/workflows/policy-scan.yml/badge.svg)](https://github.com/sheiiva/eks-boilerplate/actions/workflows/policy-scan.yml)
[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D_1.6-7B42BC?logo=terraform&logoColor=white)](./terraform/README.md)
[![License](https://img.shields.io/github/license/sheiiva/eks-boilerplate)](./LICENSE)

<p align="center">
  <img src="./docs/assets/architecture.svg" alt="EKS landing zone architecture: private VPC, EKS, Karpenter, ALB, External Secrets, Terraform modules" width="920" />
</p>

<p align="center">
  <b>AWS EKS landing zone accelerator</b> — private networking, Karpenter elasticity, platform add-ons.<br/>
  Onboard by configuration, not by rewriting modules. Live apply optional.
</p>

<p align="center">
  <a href="https://github.com/sheiiva/eks-boilerplate/releases/tag/v1.1.0">v1.1.0 release</a> ·
  <a href="https://github.com/users/sheiiva/projects/7">Project board</a> ·
  <a href="./docs/architecture.md">Architecture</a> ·
  <a href="./docs/runbooks/cost-guardrails.md">Cost guardrails</a>
</p>

Module order: **remote-state → network → eks → karpenter / addons** — detail in [`docs/architecture.md`](./docs/architecture.md).

---

## Business value

Reusable production-shaped Kubernetes baseline on AWS: security defaults first, elastic capacity via Karpenter, ingress and secrets without kubectl snowflakes — demoable as validated Terraform without a 24/7 cluster bill.

## What v1.1 demonstrates

| Layer | Capability |
|---|---|
| **IaC** | Template-first modules + `environments/demo` composition |
| **State** | S3 + DynamoDB lock bootstrap |
| **Network** | Private VPC, NAT, optional endpoints, ALB/Karpenter tags |
| **Control plane** | EKS, OIDC/IRSA, KMS secrets, access entries, full API logs |
| **Data plane** | Karpenter NodePool + interruption queue |
| **Platform** | ALB Controller + External Secrets (ExternalDNS optional) |
| **Delivery** | `fmt` / `validate` + Checkov, runbooks, releases |

Live AWS apply costs money — see [cost guardrails](./docs/runbooks/cost-guardrails.md).

---

## Quick start (no AWS spend)

```bash
git clone https://github.com/sheiiva/eks-boilerplate.git
cd eks-boilerplate
./scripts/validate.sh
```

## Apply path (ephemeral)

1. [`terraform/bootstrap`](./terraform/bootstrap/README.md) — state backend  
2. [`terraform/environments/demo`](./terraform/environments/demo/README.md) — full stack  
3. Prefer [`terraform.tfvars.hardened.example`](./terraform/environments/demo/terraform.tfvars.hardened.example) outside throwaway demos  
4. [`destroy`](./docs/runbooks/destroy.md) when done  

---

## Repository map

```text
terraform/
  bootstrap/           # one-time remote state
  modules/             # remote-state · network · eks · karpenter · addons
  environments/demo/   # reference composition
docs/
  assets/architecture.svg
  runbooks/            # bootstrap · api-access · observability · cost
examples/              # Ingress · ExternalSecret samples
```

## Docs

| Topic | Link |
|---|---|
| Architecture | [`docs/architecture.md`](./docs/architecture.md) |
| Module map | [`docs/module-map.md`](./docs/module-map.md) |
| Config model | [`docs/config-model.md`](./docs/config-model.md) |
| Roadmap | [`docs/roadmap.md`](./docs/roadmap.md) |
| Project board | [projects/7](https://github.com/users/sheiiva/projects/7) |
| API lockdown | [`docs/runbooks/api-access.md`](./docs/runbooks/api-access.md) |
| Observability | [`docs/runbooks/observability.md`](./docs/runbooks/observability.md) |
| CI / Checkov | [`docs/ci-gates.md`](./docs/ci-gates.md) |

## Status

**v1.1.0 released** (P0–P7). Optional next: GitOps sketch (P8 / [#15](https://github.com/sheiiva/eks-boilerplate/issues/15)).
