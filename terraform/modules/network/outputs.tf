output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "VPC CIDR block."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs (ALB / NAT)."
  value       = [for az in local.azs : aws_subnet.public[az].id]
}

output "private_subnet_ids" {
  description = "Private subnet IDs (nodes / internal LB)."
  value       = [for az in local.azs : aws_subnet.private[az].id]
}

output "public_subnet_cidrs" {
  description = "Public subnet CIDRs."
  value       = [for az in local.azs : aws_subnet.public[az].cidr_block]
}

output "private_subnet_cidrs" {
  description = "Private subnet CIDRs."
  value       = [for az in local.azs : aws_subnet.private[az].cidr_block]
}

output "nat_gateway_ids" {
  description = "NAT gateway IDs."
  value       = [for nat in aws_nat_gateway.this : nat.id]
}

output "availability_zones" {
  description = "Availability zones used by this network."
  value       = local.azs
}

output "private_route_table_ids" {
  description = "Private route table IDs."
  value       = [for az in local.azs : aws_route_table.private[az].id]
}
