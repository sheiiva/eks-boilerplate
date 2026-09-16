# Module Map

Planned Terraform modules and what each owns. Modules are scaffolded in P0; implementation lands in later milestones.

## Layout

```text
terraform/
  modules/
    remote-state/     # Optional bootstrap: S3 + DynamoDB (or equivalent) for state
    network/          # VPC, subnets, NAT, routes, baseline SGs / endpoints
    eks/              # EKS cluster, OIDC/IRSA plumbing, access entries
    karpenter/        # Karpenter controller IAM + NodePool / EC2NodeClass
    addons/           # ALB Controller, External-DNS, External-Secrets (Helm/EKS add-ons)
  environments/
    demo/             # Reference composition for portfolio / local dry-run
```

## Ownership

| Module | Owns | Does not own |
|---|---|---|
| `remote-state` | State bucket, lock table, encryption, versioning | Application data buckets |
| `network` | VPC CIDR layout, public/private subnets, NAT, route tables, VPC endpoints as needed | Cluster IAM, workloads |
| `eks` | Control plane, cluster IAM, cluster security groups, OIDC provider, optional managed node group for bootstrap | Karpenter NodePools, app Helm charts |
| `karpenter` | Controller install/IAM, interruption handling hooks, default NodePool/EC2NodeClass | VPC design, ALB |
| `addons` | AWS Load Balancer Controller, External-DNS, External-Secrets Operator + IRSA | App Ingress objects (examples only) |

## Dependency Order

```text
remote-state (once per account)
    → network
        → eks
            → karpenter
            → addons
```

## Interface Conventions

- Every module exposes documented `variables.tf` / `outputs.tf`
- Required tags: `project`, `environment`, `owner`, `managed_by=terraform`
- Terraform `>= 1.6`; prefer AWS provider features that support IRSA and EKS access entries
- No secrets in variables defaults or committed tfvars

## Implementation Tracking

| Module | Milestone | Status |
|---|---|---|
| Scaffold + READMEs | P0 | Done |
| `remote-state` + `network` | P1 | Done |
| `eks` | P2 | Done |
| `karpenter` | P3 | Done |
| `addons` | P4 | Planned |
| CI validate + runbooks | P5 | Planned |
