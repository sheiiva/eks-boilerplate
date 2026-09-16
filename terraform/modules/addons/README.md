# Module: addons

Platform controllers with IRSA:

- AWS Load Balancer Controller (default on)
- External Secrets Operator (default on)
- ExternalDNS (default off — needs Route53 zone)

**Status:** implemented (P4)

## Notes

- ExternalDNS stays off until `external_dns_zone_id` and `external_dns_domain_filter` are set.
- Demo environments often enable ALB + External Secrets only.
- Example manifests: `examples/` at repo root.
