# ADR 0001: Template-First EKS Landing Zone

## Status

Accepted

## Context

This repository is both a portfolio demonstration and a reusable accelerator for client AWS Kubernetes baselines. A single-account snowflake design would force rewrites on every engagement.

## Decision

Adopt a **template-first landing zone**:

- Reusable Terraform modules for network, EKS, Karpenter, and platform add-ons
- Environment-specific **compositions** under `terraform/environments/`
- Configuration-driven onboarding via the parameter model in `docs/config-model.md`
- Explicit non-goals (mesh, multi-region DR, FinOps UI) deferred to other projects or later versions

## Alternatives Considered

1. Monolithic root module per client copy-paste
2. Fully opinionated platform (GitOps + mesh + full observability stack) in v1
3. EKS Auto Mode / only managed node groups with no Karpenter

## Consequences

- Higher design effort up front (P0–P1)
- Cleaner reuse and clearer interview/client narrative
- Karpenter and IRSA-centric add-ons become the default data-plane and integration path
- Live AWS apply remains optional; IaC + docs are the primary deliverable
