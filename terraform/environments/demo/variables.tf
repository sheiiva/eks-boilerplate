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

variable "aws_region" {
  type        = string
  description = "AWS region."
}

variable "vpc_cidr" {
  type        = string
  description = "VPC IPv4 CIDR."
}

variable "az_count" {
  type        = number
  description = "Number of AZs (2 or 3)."
  default     = 2
}

variable "single_nat_gateway" {
  type        = bool
  description = "Shared NAT for cost-aware demos."
  default     = true
}

variable "enable_vpc_endpoints" {
  type        = bool
  description = "Create S3/ECR/STS/EC2/Logs VPC endpoints."
  default     = true
}

variable "cluster_name" {
  type        = string
  description = "Future EKS cluster name (subnet discovery tags)."
}
