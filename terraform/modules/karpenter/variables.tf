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
  description = "EKS cluster name (also used for karpenter.sh/discovery)."
}

variable "cluster_endpoint" {
  type        = string
  description = "EKS API endpoint."
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider ARN for IRSA."
}

variable "oidc_provider_url" {
  type        = string
  description = "OIDC issuer host path (without https://)."
}

variable "cluster_security_group_id" {
  type        = string
  description = "Cluster security group ID attached to nodes."
}

variable "karpenter_version" {
  type        = string
  description = "Karpenter Helm chart version."
  default     = "1.0.6"
}

variable "namespace" {
  type        = string
  description = "Namespace for Karpenter controller."
  default     = "kube-system"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
