# Production-Ready EKS Boilerplate

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)

## Business Value

This project demonstrates a production-grade Kubernetes landing zone on AWS that reduces time-to-market while preserving enterprise-grade security, scalability, and operational consistency.

## Technical Stack

- Terraform/OpenTofu for infrastructure as code
- AWS EKS with Karpenter for elastic node provisioning
- Private VPC topology with NAT Gateways and ALB Controller
- External-DNS and External-Secrets Operator
- Remote state and locking for safe collaborative IaC workflows

## Directory Layout

- `terraform/`: reusable modules and environment compositions
- `scripts/`: automation and validation helpers
- `docs/`: architecture decisions, runbooks, and operations notes

## Delivery docs

- Roadmap: [`docs/roadmap.md`](./docs/roadmap.md)
- Architecture: [`docs/architecture.md`](./docs/architecture.md)
- Module map: [`docs/module-map.md`](./docs/module-map.md)
- Config model: [`docs/config-model.md`](./docs/config-model.md)

## Current status

**P0 (productization) complete** — design docs and Terraform scaffolds are in place. Implementation of network, EKS, Karpenter, and add-ons follows milestones P1–P5.
