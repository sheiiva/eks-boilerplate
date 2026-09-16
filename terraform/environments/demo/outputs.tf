output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "availability_zones" {
  value = module.network.availability_zones
}

output "cluster_name" {
  value = var.cluster_name
}

output "cluster_endpoint" {
  value = try(module.eks[0].cluster_endpoint, null)
}

output "oidc_provider_arn" {
  value = try(module.eks[0].oidc_provider_arn, null)
}

output "configure_kubectl" {
  description = "Command to configure kubectl for this cluster."
  value       = var.enable_eks ? "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.cluster_name}" : null
}
