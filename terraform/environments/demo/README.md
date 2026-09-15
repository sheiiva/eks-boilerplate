# Environment: demo

Reference composition wiring landing-zone modules for a portfolio / dry-run demo.

**Status:** scaffold (wired as modules land in P1–P4)

## Intent

- Non-production defaults (e.g. single NAT) for cost-aware demos
- Example tfvars without secrets (`terraform.tfvars.example` in a later milestone)

## Apply note

Live `terraform apply` requires an AWS account and remote state from P1+. Until then, this directory documents the intended composition shape.
