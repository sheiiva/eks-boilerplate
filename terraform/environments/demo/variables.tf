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
  description = "EKS cluster name."
}

variable "kubernetes_version" {
  type        = string
  description = "EKS Kubernetes version."
  default     = "1.31"
}

variable "enable_eks" {
  type        = bool
  description = "Provision the EKS control plane."
  default     = true
}

variable "endpoint_private_access" {
  type    = bool
  default = true
}

variable "endpoint_public_access" {
  type    = bool
  default = true
}

variable "public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "enable_cluster_encryption" {
  type    = bool
  default = true
}

variable "enable_bootstrap_node_group" {
  type    = bool
  default = true
}

variable "bootstrap_desired_size" {
  type    = number
  default = 2
}

variable "bootstrap_min_size" {
  type    = number
  default = 1
}

variable "bootstrap_max_size" {
  type    = number
  default = 3
}

variable "cluster_admin_principal_arns" {
  type    = list(string)
  default = []
}

variable "enable_karpenter" {
  type        = bool
  description = "Install Karpenter after EKS is ready."
  default     = true
}
