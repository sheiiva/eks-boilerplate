terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12, < 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.27"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
  }

  # Configure after bootstrap: terraform init -backend-config=backend.hcl
  backend "s3" {}
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

data "aws_eks_cluster_auth" "this" {
  count = var.enable_eks ? 1 : 0
  name  = module.eks[0].cluster_name
}

provider "kubernetes" {
  host                   = try(module.eks[0].cluster_endpoint, null)
  cluster_ca_certificate = try(base64decode(module.eks[0].cluster_certificate_authority_data), null)
  token                  = try(data.aws_eks_cluster_auth.this[0].token, null)
}

provider "helm" {
  kubernetes {
    host                   = try(module.eks[0].cluster_endpoint, null)
    cluster_ca_certificate = try(base64decode(module.eks[0].cluster_certificate_authority_data), null)
    token                  = try(data.aws_eks_cluster_auth.this[0].token, null)
  }
}

module "network" {
  source = "../../modules/network"

  project_name         = var.project_name
  environment          = var.environment
  owner                = var.owner
  vpc_cidr             = var.vpc_cidr
  az_count             = var.az_count
  single_nat_gateway   = var.single_nat_gateway
  enable_vpc_endpoints = var.enable_vpc_endpoints
  cluster_name         = var.cluster_name
}

module "eks" {
  count  = var.enable_eks ? 1 : 0
  source = "../../modules/eks"

  project_name                 = var.project_name
  environment                  = var.environment
  owner                        = var.owner
  cluster_name                 = var.cluster_name
  kubernetes_version           = var.kubernetes_version
  subnet_ids                   = module.network.private_subnet_ids
  endpoint_private_access      = var.endpoint_private_access
  endpoint_public_access       = var.endpoint_public_access
  public_access_cidrs          = var.public_access_cidrs
  enable_cluster_encryption    = var.enable_cluster_encryption
  enable_bootstrap_node_group  = var.enable_bootstrap_node_group
  bootstrap_desired_size       = var.bootstrap_desired_size
  bootstrap_min_size           = var.bootstrap_min_size
  bootstrap_max_size           = var.bootstrap_max_size
  cluster_admin_principal_arns = var.cluster_admin_principal_arns
}

module "karpenter" {
  count  = var.enable_eks && var.enable_karpenter ? 1 : 0
  source = "../../modules/karpenter"

  project_name              = var.project_name
  environment               = var.environment
  owner                     = var.owner
  cluster_name              = module.eks[0].cluster_name
  cluster_endpoint          = module.eks[0].cluster_endpoint
  oidc_provider_arn         = module.eks[0].oidc_provider_arn
  oidc_provider_url         = module.eks[0].oidc_provider_url
  cluster_security_group_id = module.eks[0].cluster_security_group_id
}
