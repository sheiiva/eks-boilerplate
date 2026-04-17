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
