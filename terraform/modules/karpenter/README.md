# Module: karpenter

Karpenter controller (Helm + IRSA), interruption queue, node IAM/instance profile, and default `EC2NodeClass` / `NodePool`.

**Status:** implemented (P3)

## Prerequisites

- EKS cluster with OIDC (`modules/eks`)
- Private subnets tagged `karpenter.sh/discovery = <cluster_name>` (`modules/network`)
- Helm and Kubernetes providers authenticated to the cluster

## Notes

- Default NodePool allows on-demand + spot; consolidation is `WhenEmptyOrUnderutilized`.
- Bootstrap managed node group (EKS module) should remain until Karpenter is Ready.
- After Karpenter is healthy, scale the bootstrap group down for cost if desired.
