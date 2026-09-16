variable "project_name" {
  type        = string
  description = "Short project name used in resource naming."
}

variable "environment" {
  type        = string
  description = "Lifecycle stage."
}

variable "owner" {
  type        = string
  description = "Owner tag value."
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider ARN for IRSA."
}

variable "oidc_provider_url" {
  type        = string
  description = "OIDC issuer host path (without https://)."
}

variable "enable_alb_controller" {
  type        = bool
  description = "Install AWS Load Balancer Controller."
  default     = true
}

variable "enable_external_dns" {
  type        = bool
  description = "Install ExternalDNS."
  default     = false
}

variable "enable_external_secrets" {
  type        = bool
  description = "Install External Secrets Operator."
  default     = true
}

variable "external_dns_zone_id" {
  type        = string
  description = "Route53 hosted zone ID for ExternalDNS (required when enable_external_dns)."
  default     = ""
}

variable "external_dns_domain_filter" {
  type        = string
  description = "Domain filter for ExternalDNS."
  default     = ""
}

variable "secrets_backend" {
  type        = string
  description = "Secrets backend for External Secrets: secretsmanager or ssm."
  default     = "secretsmanager"

  validation {
    condition     = contains(["secretsmanager", "ssm"], var.secrets_backend)
    error_message = "secrets_backend must be secretsmanager or ssm."
  }
}

variable "alb_chart_version" {
  type        = string
  description = "AWS Load Balancer Controller Helm chart version."
  default     = "1.8.1"
}

variable "external_dns_chart_version" {
  type        = string
  description = "ExternalDNS Helm chart version."
  default     = "1.14.5"
}

variable "external_secrets_chart_version" {
  type        = string
  description = "External Secrets Operator Helm chart version."
  default     = "0.9.20"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
