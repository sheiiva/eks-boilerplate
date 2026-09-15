# Architecture Overview

## Intent

Reusable **AWS EKS landing zone** accelerator: a production-shaped Kubernetes platform that a team can adopt by configuration, not by rewriting core modules.

Portfolio and client reuse share the same design: private-by-default networking, managed control plane, elastic nodes via Karpenter, and a minimal add-on set for ingress, DNS, and secrets.

## System Diagram

```mermaid
flowchart TB
  subgraph Edge
    Users[Clients / operators]
    DNS[Route53 / External-DNS]
    ALB[AWS Load Balancer Controller]
  end

  subgraph Network["Private VPC"]
    PUB[Public subnets + NAT]
    PRIV[Private subnets]
  end

  subgraph Control["EKS control plane"]
    API[EKS API / kube-apiserver]
  end

  subgraph DataPlane["Data plane"]
    Karp[Karpenter]
    Nodes[EC2 nodes / NodePools]
    Workloads[Workloads]
  end

  subgraph Platform["Cluster platform add-ons"]
    ESO[External Secrets Operator]
    SM[AWS Secrets Manager / SSM]
  end

  subgraph IaC["Terraform / OpenTofu"]
    State[Remote state + lock]
    Mods[Modules: network · eks · karpenter · addons]
  end

  Users --> ALB
  ALB --> Workloads
  DNS --> ALB
  PUB --> PRIV
  PRIV --> Nodes
  API --> Nodes
  Karp --> Nodes
  Workloads --> Nodes
  ESO --> SM
  Workloads --> ESO
  State --> Mods
  Mods --> Network
  Mods --> Control
  Mods --> Karp
  Mods --> Platform
```

## Design Principles

- **Template-first** — environment differences live in composition/vars, not forks of modules.
- **Private-by-default** — workloads and nodes in private subnets; explicit public ingress only via ALB.
- **Least privilege** — IRSA for controllers and workloads; no long-lived node credentials for AWS APIs where avoidable.
- **Elastic capacity** — Karpenter owns node lifecycle; avoid large static node groups except a thin bootstrap path if required.
- **Safe collaboration** — remote state with locking; CI validate/fmt/policy before apply.
- **Operability** — architecture, module map, and runbooks are first-class deliverables.

## Module Map

See [`module-map.md`](./module-map.md) for ownership boundaries and planned Terraform layout.

## Environment Model

| Layer | Role |
|---|---|
| `terraform/modules/*` | Reusable building blocks (inputs/outputs only; no account-specific hardcoding) |
| `terraform/environments/<env>` | Composition: wires modules for `dev` / `staging` / `prod` (or client demo) |
| Config / tfvars | CIDRs, region, cluster name, domain, tags, feature toggles |

Onboarding a new tenant or environment should mean new composition + variables, not edits inside module internals.

## Security Baseline (target)

- Encryption at rest for EKS secrets (envelope encryption with KMS) and EBS where applicable
- Restricted security groups and private API endpoint option documented per environment
- Secrets only via Secrets Manager / SSM through External Secrets — never in git
- Image and IaC scanning gates in CI (introduced in later milestones)

## Explicit Non-Goals (initial releases)

- Multi-cluster / multi-region mesh (see separate portfolio project for DR patterns)
- Full service mesh or opinionated app platform (Argo CD, Istio, etc.) — optional later
- Cost dashboards (covered by `finops-dashboard`)
- Guaranteed live AWS demo account in the public repo (docs + IaC are the product; apply is optional)

## Related Docs

- Roadmap: [`roadmap.md`](./roadmap.md)
- Config / parameter model: [`config-model.md`](./config-model.md)
- Decision log: [`decision-log/`](./decision-log/)
