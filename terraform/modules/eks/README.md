# Module: eks

EKS control plane with OIDC/IRSA, optional secrets encryption (KMS), access entries, managed add-ons (vpc-cni, coredns, kube-proxy), and an optional thin bootstrap node group for initial controllers.

**Status:** implemented (P2)

## Usage

```hcl
module "eks" {
  source = "../../modules/eks"

  project_name       = "eks-lz"
  environment        = "demo"
  owner              = "platform"
  cluster_name       = "eks-lz-demo"
  kubernetes_version = "1.31"
  subnet_ids         = module.network.private_subnet_ids
}
```

## Operator access

```bash
aws eks update-kubeconfig --name <cluster_name> --region <region>
```

Access entries grant `AmazonEKSClusterAdminPolicy` to extra ARNs in `cluster_admin_principal_arns`. The cluster creator receives admin via `bootstrap_cluster_creator_admin_permissions`.

## Notes

- Public API endpoint defaults to on for demo/operator laptops; restrict `public_access_cidrs` in real environments.
- Keep the bootstrap node group until Karpenter is healthy, then scale it down if desired.
