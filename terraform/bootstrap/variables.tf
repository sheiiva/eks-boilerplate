variable "project_name" {
  type        = string
  description = "Short project name used in resource naming."
  default     = "eks-lz"
}

variable "environment" {
  type        = string
  description = "Lifecycle stage."
  default     = "demo"
}

variable "owner" {
  type        = string
  description = "Owner tag value."
  default     = "platform"
}

variable "aws_region" {
  type        = string
  description = "AWS region for state backend resources."
  default     = "eu-west-1"
}

variable "state_bucket_name" {
  type        = string
  description = "Optional override for the state bucket name (must be globally unique)."
  default     = ""
}

variable "lock_table_name" {
  type        = string
  description = "Optional override for the DynamoDB lock table name."
  default     = ""
}

variable "force_destroy" {
  type        = bool
  description = "Allow destroying the state bucket with objects (demo only)."
  default     = false
}
