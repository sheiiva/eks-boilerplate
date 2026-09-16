# CI Gates

## Gates on every push / PR

| Workflow | What it does |
|---|---|
| `terraform-validate.yml` | `terraform fmt -check` + `validate` for each module/composition |
| `policy-scan.yml` | Checkov misconfiguration scan (`soft_fail: false`) |

Local equivalents:

```bash
./scripts/validate.sh
docker run --rm -v "$PWD:/tf" bridgecrew/checkov:3.2.257 \
  -d /tf/terraform --config-file /tf/.checkov.yaml --framework terraform
```

## Checkov suppressions

Configured in [`.checkov.yaml`](../.checkov.yaml). Skips are intentional product trade-offs, not blind silencing.

| Check | Why skipped |
|---|---|
| `CKV_AWS_38` / `CKV_AWS_39` | Demo default allows public API; harden with `terraform.tfvars.hardened.example` |
| `CKV_AWS_130` | Public subnets must map public IPs for NAT / internet-facing ALB |
| `CKV_AWS_18` / `144` / `145` / `CKV2_AWS_62` | State bucket uses AES256 + versioning + TLS deny; CRR/logging/events optional |
| `CKV_AWS_119` | Lock table metadata; AWS-owned encryption is enough for this accelerator |
| `CKV2_AWS_11` | VPC flow logs are cost-bearing; covered as optional in observability runbook |
| `CKV_AWS_111` / `356` | Karpenter + ALB controller IAM follow upstream AWS shapes |
| `CKV_AWS_58` | Secrets encryption is on by default; Checkov misses the dynamic block |
| `CKV2_AWS_5` | VPC endpoint security group is attached to interface endpoints |
| `CKV_AWS_109` | KMS key policy grants account root admin (AWS default pattern) + EKS service use |
| `CKV_AWS_339` / `CKV_AWS_37` | Module defaults to Kubernetes 1.32 and all five control-plane log types; Checkov graph/policy pack can lag |

## Failure policy

- Fmt / validate failures block merge.
- Checkov high/medium findings that are **not** skipped block merge.
- New skips require a one-line rationale in this file and `.checkov.yaml`.
