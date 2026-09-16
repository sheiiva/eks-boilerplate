# Cost Guardrails

Live AWS applies cost money. Treat demos as **ephemeral**.

## Biggest cost drivers

| Resource | Notes |
|---|---|
| EKS control plane | ~$0.10/hour while the cluster exists |
| NAT Gateway | ~$0.045/hour + data; demo uses one (`single_nat_gateway = true`) |
| VPC interface endpoints | Multiple $/hour when enabled — default demo tfvars set `enable_vpc_endpoints = false` |
| EC2 nodes | Bootstrap node group + Karpenter nodes |

## Before apply

- Use a disposable AWS account or hard spend alarm.
- Prefer `eu-west-1` (or your cheapest region).
- Keep ExternalDNS off unless you own a Route53 zone.
- Set `public_access_cidrs` to your IP in non-throwaway accounts.

## After demo

```bash
cd terraform/environments/demo
terraform destroy
```

Then optionally destroy bootstrap state resources if you no longer need the backend.

## Portfolio posture

Validated Terraform + docs are enough for portfolio/interview proof. Live cluster is optional evidence, not a requirement.
