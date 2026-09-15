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

variable "aws_region" {
  type        = string
  description = "AWS region for the state bucket and lock table."
}

variable "state_bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name for Terraform state. Leave empty to derive from project/environment."
  default     = ""
}

variable "lock_table_name" {
  type        = string
  description = "DynamoDB table name for state locking. Leave empty to derive from project/environment."
  default     = ""
}

variable "force_destroy" {
  type        = bool
  description = "Allow bucket destroy even if objects remain. Keep false outside disposable demos."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Additional tags merged with mandatory tags."
  default     = {}
}
