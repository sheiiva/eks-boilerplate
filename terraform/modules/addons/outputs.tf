output "alb_controller_role_arn" {
  description = "IRSA role ARN for AWS Load Balancer Controller."
  value       = try(aws_iam_role.irsa["alb"].arn, null)
}

output "external_dns_role_arn" {
  description = "IRSA role ARN for ExternalDNS."
  value       = try(aws_iam_role.irsa["external_dns"].arn, null)
}

output "external_secrets_role_arn" {
  description = "IRSA role ARN for External Secrets Operator."
  value       = try(aws_iam_role.irsa["external_secrets"].arn, null)
}
