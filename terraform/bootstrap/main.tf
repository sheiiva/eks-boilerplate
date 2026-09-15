terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  # Bootstrap uses local state on purpose. After apply, point environments/* at the outputs.
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      project     = var.project_name
      environment = var.environment
      owner       = var.owner
      managed_by  = "terraform"
    }
  }
}

module "remote_state" {
  source = "../modules/remote-state"

  project_name      = var.project_name
  environment       = var.environment
  owner             = var.owner
  aws_region        = var.aws_region
  state_bucket_name = var.state_bucket_name
  lock_table_name   = var.lock_table_name
  force_destroy     = var.force_destroy
}
