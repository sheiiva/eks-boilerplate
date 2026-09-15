variable "project_name" {
  type        = string
  description = "Short project name used in resource naming."
}

variable "environment" {
  type        = string
  description = "Lifecycle stage (e.g. demo, dev, prod)."
}

variable "owner" {
  type        = string
  description = "Owner tag value."
}

variable "vpc_cidr" {
  type        = string
  description = "VPC IPv4 CIDR block."
}

variable "az_count" {
  type        = number
  description = "Number of availability zones (2–3 typical)."
  default     = 2

  validation {
    condition     = var.az_count >= 2 && var.az_count <= 3
    error_message = "az_count must be 2 or 3."
  }
}

variable "single_nat_gateway" {
  type        = bool
  description = "Use one shared NAT gateway (cheaper non-prod) instead of one per AZ."
  default     = true
}

variable "enable_vpc_endpoints" {
  type        = bool
  description = "Create S3 gateway + interface endpoints for ECR/STS/EC2/Logs."
  default     = true
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name used for subnet discovery tags (ALB / Karpenter)."
}

variable "tags" {
  type        = map(string)
  description = "Additional tags merged with mandatory tags."
  default     = {}
}
