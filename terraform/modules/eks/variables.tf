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

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "kubernetes_version" {
  type        = string
  description = "EKS Kubernetes version."
  default     = "1.32"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the control plane ENIs (typically private)."
}

variable "endpoint_private_access" {
  type        = bool
  description = "Enable private API endpoint."
  default     = true
}

variable "endpoint_public_access" {
  type        = bool
  description = "Enable public API endpoint (useful for portfolio demos / operator laptops)."
  default     = true
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to reach the public API endpoint when enabled."
  default     = ["0.0.0.0/0"]
}

variable "enable_cluster_encryption" {
  type        = bool
  description = "Enable secrets envelope encryption with a dedicated KMS key."
  default     = true
}

variable "enable_bootstrap_node_group" {
  type        = bool
  description = "Create a thin managed node group so Karpenter/controllers can schedule before scale-out."
  default     = true
}

variable "bootstrap_instance_types" {
  type        = list(string)
  description = "Instance types for the bootstrap managed node group."
  default     = ["t3.medium"]
}

variable "bootstrap_desired_size" {
  type        = number
  description = "Desired size of the bootstrap node group."
  default     = 2
}

variable "bootstrap_min_size" {
  type        = number
  description = "Minimum size of the bootstrap node group."
  default     = 1
}

variable "bootstrap_max_size" {
  type        = number
  description = "Maximum size of the bootstrap node group."
  default     = 3
}

variable "cluster_admin_principal_arns" {
  type        = list(string)
  description = "IAM principal ARNs granted AmazonEKSClusterAdminPolicy via access entries."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags merged with mandatory tags."
  default     = {}
}
