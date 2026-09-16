# Observability Baseline

Minimum signals for a production-shaped EKS landing zone. **Full APM / tracing platforms are out of scope** for this accelerator.

## Day-1 (enable with the cluster)

| Signal | Where | Notes |
|---|---|---|
| Control plane logs | CloudWatch Log Group `/aws/eks/<cluster>/cluster` | Module enables `api`, `audit`, `authenticator`, `controllerManager`, `scheduler` |
| Node readiness | `kubectl get nodes` / EKS console | Bootstrap node group + Karpenter NodeClaims |
| Addon health | `kubectl -n kube-system get pods` | CoreDNS, VPC CNI, kube-proxy, Karpenter, ALB controller |
| API auth failures | CloudWatch audit / authenticator logs | Spike after bad CI credentials or CIDR lock mistakes |

## Day-1 alerts (suggested)

1. **Cluster unreachable** — API server errors or failed `aws eks describe-cluster`.
2. **Node NotReady > 5m** — bootstrap or Karpenter capacity issue.
3. **Karpenter / ALB controller CrashLoop** — IRSA or subnet tag misconfig.
4. **NAT gateway ErrorPortAllocation / elevated bytes** — egress saturation (cost + reliability).

Wire these to SNS/email/Slack via CloudWatch Alarms or your existing notifier. Exact alarm JSON is environment-specific.

## Optional (enable when spend justifies it)

| Signal | Option | Cost note |
|---|---|---|
| VPC flow logs | S3 or CloudWatch | Can dominate demo cost — keep off for short smoke tests |
| ALB access logs | S3 bucket | Useful once Ingress examples are live |
| Container Insights | CloudWatch addon | Convenient; not required for portfolio proof |
| Prometheus / Grafana in-cluster | kube-prometheus-stack | Prefer only if you already operate that stack |

## Operator quick checks

```bash
aws eks update-kubeconfig --region <region> --name <cluster>
kubectl get nodes -o wide
kubectl get pods -A | grep -Ev 'Running|Completed'
kubectl logs -n kube-system deploy/karpenter --tail=100
aws logs tail /aws/eks/<cluster>/cluster --since 30m --format short
```

## Non-goals

- Application-level APM (Datadog, New Relic, OpenTelemetry meshes)
- Multi-cluster federation dashboards
- On-call rotation design (see client runbooks)

## Related

- API exposure: [`api-access.md`](./api-access.md)
- Cost discipline: [`cost-guardrails.md`](./cost-guardrails.md)
- CI / Checkov: [`../ci-gates.md`](../ci-gates.md)
