# Configuration and Parameter Model

Goal: onboard a new environment or client demo by editing composition variables, not module source.

## Required parameters

| Parameter | Description | Example |
|---|---|---|
| `project_name` | Short name used in resource naming | `eks-lz` |
| `environment` | Lifecycle stage | `demo`, `dev`, `prod` |
| `aws_region` | Primary region | `eu-west-1` |
| `vpc_cidr` | VPC CIDR | `10.40.0.0/16` |
| `cluster_name` | EKS cluster name | `eks-lz-demo` |
| `kubernetes_version` | EKS version pin | `1.31` |
| `owner` | Tag / contact | `platform` |

## Networking parameters

| Parameter | Description |
|---|---|
| `az_count` | Number of AZs (typically 2–3) |
| `single_nat_gateway` | Cost trade-off for non-prod (`true` demo / `false` prod HA) |
| `enable_vpc_endpoints` | Optional S3/ECR/STS endpoints to cut NAT cost and harden egress |

## Platform parameters

| Parameter | Description |
|---|---|
| `domain_name` | Optional public DNS zone name for External-DNS |
| `external_dns_zone_id` | Route53 zone ID when DNS automation is enabled |
| `secrets_backend` | `secretsmanager` \| `ssm` (default Secrets Manager) |
| `enable_karpenter` | Feature toggle (default `true` after P3) |
| `enable_alb_controller` | Feature toggle (default `true` after P4) |
| `enable_external_dns` | Feature toggle |
| `enable_external_secrets` | Feature toggle |

## Mandatory tags

Applied on all taggable resources:

```hcl
project     = var.project_name
environment = var.environment
owner       = var.owner
managed_by  = "terraform"
```

## Non-secrets rule

- No API keys, kubeconfig, or TLS material in tfvars committed to git
- Use AWS IAM + IRSA; inject application secrets via External Secrets at runtime

## Composition pattern

```text
environments/demo/
  main.tf          # module wiring only
  variables.tf
  terraform.tfvars # non-secret values (or *.tfvars.example committed)
  backend.tf       # remote state config
  outputs.tf
```

Reference values ship as `terraform.tfvars.example` so clones can copy → `terraform.tfvars` locally.
