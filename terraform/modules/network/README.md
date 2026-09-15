# Module: network

Private-by-default VPC for the EKS landing zone: public/private subnets, NAT, optional VPC endpoints, and EKS/Karpenter discovery tags.

**Status:** implemented (P1)

## Usage

```hcl
module "network" {
  source = "../../modules/network"

  project_name         = "eks-lz"
  environment          = "demo"
  owner                = "platform"
  vpc_cidr             = "10.40.0.0/16"
  az_count             = 2
  single_nat_gateway   = true
  enable_vpc_endpoints = true
  cluster_name         = "eks-lz-demo"
}
```

## Notes

- Public subnets tagged for internet-facing ALB discovery; private for internal ELB + `karpenter.sh/discovery`.
- `single_nat_gateway = true` is the demo/default cost profile; set `false` for per-AZ NAT in production.
- Interface endpoints: `ecr.api`, `ecr.dkr`, `sts`, `ec2`, `logs` plus S3 gateway when `enable_vpc_endpoints` is true.
