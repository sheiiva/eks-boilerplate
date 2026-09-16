# Roadmap

This roadmap maps GitHub milestones to delivery outcomes for the EKS landing zone accelerator.

**Project board:** https://github.com/users/sheiiva/projects/7

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

### P0 acceptance

- [x] Architecture doc with diagram and non-goals
- [x] Module map with dependency order
- [x] Config / parameter model
- [x] ADR template-first landing zone
- [x] Terraform layout scaffold + module stub READMEs
- [x] Roadmap published; GitHub milestones created

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

### P2 acceptance

- [x] `modules/eks` with OIDC, KMS encryption, access entries, managed add-ons
- [x] Optional bootstrap managed node group
- [x] Operator access documented

## P3 - Karpenter Node Autoscaling

Deliverables:

- Karpenter IAM / IRSA and controller install
- Default NodePool and EC2NodeClass aligned to private subnets
- Scale-from-zero / consolidation notes

Outcome:

- Elastic data plane without oversized static node groups.

### P3 acceptance

- [x] Controller IRSA + interruption SQS/EventBridge
- [x] Helm install + default EC2NodeClass/NodePool
- [x] Consolidation notes in module README

## P4 - Platform Add-ons

Deliverables:

- AWS Load Balancer Controller
- External-DNS
- External-Secrets Operator (Secrets Manager / SSM)
- Minimal example Ingress + ExternalSecret (docs or `examples/`)

Outcome:

- Cluster can expose services and consume secrets without kubectl snowflakes.

### P4 acceptance

- [x] `modules/addons` with feature toggles
- [x] Examples under `examples/`

## P5 - CI Gates and Operations

Deliverables:

- `terraform fmt` / `validate` (and policy scan) in CI
- Operator runbooks: bootstrap, upgrade notes, destroy/cost guardrails
- README aligned to demo composition

Outcome:

- Portfolio-ready accelerator with auditable change path.

### P5 acceptance

- [x] GitHub Actions terraform fmt/validate matrix
- [x] Runbooks: bootstrap, destroy, cost guardrails
- [x] README v1 positioning (apply optional)

## P6 - Hardening and Security Posture (v1.1)

Deliverables:

- Private API / CIDR lockdown documentation and examples
- Policy-as-code CI gate (Checkov or equivalent)

Outcome:

- Production-shaped access and automated misconfiguration detection.

## P7 - Observability Hooks (v1.1)

Deliverables:

- Baseline observability runbook (control plane, nodes, ALB)

Outcome:

- Clear day-1 signals without mandating a full APM stack.

## P8 - GitOps and Multi-Account Patterns (v2)

Deliverables:

- Optional GitOps adoption sketch (Argo CD / Flux)

Outcome:

- Documented path beyond the landing zone without expanding v1 scope.

## Product versions

| Version | What ships | Tracking |
|---|---|---|
| **v0** | Productization: docs, module map, scaffold, milestones | P0 (Done) |
| **v1** | Network + EKS + Karpenter + core add-ons + CI | P1–P5 (Done) |
| **v1.1** | Hardening + observability hooks | P6–P7 (Todo) |
| **v2** | Optional GitOps / multi-account patterns | P8 (Later) |
