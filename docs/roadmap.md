# Roadmap

This roadmap maps GitHub milestones to delivery outcomes for the EKS landing zone accelerator.

## P0 - Productization and Landing Zone Design

Deliverables:

- Architecture overview and system diagram
- Module map and ownership boundaries
- Environment / parameter model
- ADR: template-first landing zone
- Terraform directory scaffold (modules + demo environment stubs)
- Public roadmap and GitHub milestones

Outcome:

- Clear product shape before writing cluster resources; onboarding path is configuration-driven.

## P1 - Remote State and Network Foundation

Deliverables:

- Remote state bootstrap (S3 + lock) documented and modular
- Private VPC topology with public/private subnets and NAT
- Optional VPC endpoints (S3/ECR/STS/EC2/Logs)
- Baseline tagging and outputs consumed by EKS
- Demo composition wiring + `*.example` configs

Outcome:

- Safe IaC collaboration and a private network ready for the control plane.

### P1 acceptance

- [x] `modules/remote-state` implemented and documented
- [x] `terraform/bootstrap` composition for one-time apply
- [x] `modules/network` with EKS/Karpenter discovery tags
- [x] `environments/demo` wires network; backend/tfvars examples committed

## P2 - EKS Control Plane

Deliverables:

- EKS cluster module (OIDC, encryption posture, access model)
- Thin bootstrap compute path if required for first controllers
- kubeconfig / access documentation for operators

Outcome:

- Usable managed Kubernetes API in private networking.

## P3 - Karpenter Node Autoscaling

Deliverables:

- Karpenter IAM / IRSA and controller install
- Default NodePool and EC2NodeClass aligned to private subnets
- Scale-from-zero / consolidation notes

Outcome:

- Elastic data plane without oversized static node groups.

## P4 - Platform Add-ons

Deliverables:

- AWS Load Balancer Controller
- External-DNS
- External-Secrets Operator (Secrets Manager / SSM)
- Minimal example Ingress + ExternalSecret (docs or `examples/`)

Outcome:

- Cluster can expose services and consume secrets without kubectl snowflakes.

## P5 - CI Gates and Operations

Deliverables:

- `terraform fmt` / `validate` (and policy scan) in CI
- Operator runbooks: bootstrap, upgrade notes, destroy/cost guardrails
- README aligned to demo composition

Outcome:

- Portfolio-ready accelerator with auditable change path.

## Product versions (current focus)

| Version | What ships | Tracking |
|---|---|---|
| **v0** | Productization: docs, module map, scaffold, milestones | P0 |
| **v1** | Network + EKS + Karpenter + core add-ons + CI | P1–P5 |
| **v1.1** | Hardening (private API options, tighter SG, observability hooks) | later |
| **v2** | Optional GitOps / mesh / multi-account patterns | later |

### P0 acceptance

- [x] Architecture doc with diagram and non-goals
- [x] Module map with dependency order
- [x] Config / parameter model
- [x] ADR template-first landing zone
- [x] Terraform layout scaffold + module stub READMEs
- [x] Roadmap published; GitHub milestones created
