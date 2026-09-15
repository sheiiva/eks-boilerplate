# Module: network

Private-by-default VPC for the EKS landing zone.

**Status:** scaffold (implementation in **P1**)

## Planned inputs

- `vpc_cidr`, `az_count`, `single_nat_gateway`, tags
- Optional VPC endpoints toggle

## Planned outputs

- `vpc_id`, public/private subnet IDs, NAT IDs, route table IDs
