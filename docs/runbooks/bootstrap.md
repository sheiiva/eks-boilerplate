# Bootstrap

## Order

1. **Remote state** — `terraform/bootstrap` (local state) creates S3 + DynamoDB lock.
2. **Demo composition** — copy `backend.hcl.example` → `backend.hcl` using bootstrap outputs.
3. **Plan / apply** — `terraform/environments/demo`.

```bash
cd terraform/bootstrap
cp terraform.tfvars.example terraform.tfvars
terraform init && terraform apply

cd ../environments/demo
cp terraform.tfvars.example terraform.tfvars
cp backend.hcl.example backend.hcl
# edit backend.hcl
terraform init -backend-config=backend.hcl
terraform apply
```

## Access

```bash
aws eks update-kubeconfig --region <region> --name <cluster_name>
kubectl get nodes
kubectl get pods -n kube-system
```

API endpoint exposure (`public` / CIDR lock / private-only) is documented in [`api-access.md`](./api-access.md). Copy `terraform.tfvars.hardened.example` for a CIDR-restricted starting point.

## Validation without AWS spend

```bash
./scripts/validate.sh
```
