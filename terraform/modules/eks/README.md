# Module: eks

EKS control plane, cluster IAM, OIDC provider, and access model.

**Status:** scaffold (implementation in **P2**)

## Planned inputs

- `cluster_name`, `kubernetes_version`, subnet IDs, KMS options
- Bootstrap node group toggle (thin path for initial controllers if needed)

## Planned outputs

- `cluster_name`, `cluster_endpoint`, `oidc_provider_arn`, `cluster_security_group_id`
