# EKS API Access Lockdown

Controls how operators reach the Kubernetes API. All knobs are composition variables — no module source changes required.

## Variables

| Variable | Demo default | Production-shaped |
|---|---|---|
| `endpoint_private_access` | `true` | `true` |
| `endpoint_public_access` | `true` | `false` **or** `true` with tight CIDRs |
| `public_access_cidrs` | `["0.0.0.0/0"]` | Your operator / VPN / bastion CIDRs only |

Defined on `modules/eks` and passed from `environments/demo`.

## Patterns

### A — Portfolio / laptop demo (current example)

```hcl
endpoint_private_access = true
endpoint_public_access  = true
public_access_cidrs     = ["0.0.0.0/0"]
```

**Warning:** `0.0.0.0/0` is **portfolio/demo-only**. Do not use on shared or production accounts.

### B — Public API, CIDR-restricted (common for small teams)

```hcl
endpoint_private_access = true
endpoint_public_access  = true
public_access_cidrs     = ["203.0.113.10/32"]  # replace with your public IP or office/VPN egress
```

Operators still use `aws eks update-kubeconfig` from an allowed IP.

### C — Private API only (strongest)

```hcl
endpoint_private_access = true
endpoint_public_access  = false
# public_access_cidrs is ignored when public endpoint is off
```

Requires network path into the VPC: VPN, Direct Connect, SSM bastion, or similar. Document that path in your client runbook before enabling.

## Example files

| File | Intent |
|---|---|
| `terraform/environments/demo/terraform.tfvars.example` | Open demo (explicitly marked) |
| `terraform/environments/demo/terraform.tfvars.hardened.example` | CIDR-locked starting point |

```bash
cp terraform.tfvars.hardened.example terraform.tfvars
# edit public_access_cidrs to your IP
```

## Related

- Cost / destroy discipline: [`cost-guardrails.md`](./cost-guardrails.md)
- Bootstrap order: [`bootstrap.md`](./bootstrap.md)
