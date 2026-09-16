#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

terraform fmt -recursive terraform

paths=(
  terraform/modules/remote-state
  terraform/modules/network
  terraform/modules/eks
  terraform/modules/karpenter
  terraform/modules/addons
  terraform/bootstrap
  terraform/environments/demo
)

for d in "${paths[@]}"; do
  echo "==== validate ${d} ===="
  terraform -chdir="$d" init -backend=false -input=false -upgrade >/dev/null
  terraform -chdir="$d" validate
done

echo "ALL_OK"
