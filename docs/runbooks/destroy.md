# Destroy / Teardown

1. Delete demo workloads / Ingress (ALBs) if any were created manually.
2. `terraform destroy` in `environments/demo`.
3. Confirm no leftover ALBs, ENIs, or Karpenter nodes in the AWS console.
4. Optionally destroy `terraform/bootstrap` (state bucket must be empty or `force_destroy = true`).

If destroy hangs on node groups, check for finalizers / stuck Karpenter NodeClaims and delete them, then re-run destroy.
