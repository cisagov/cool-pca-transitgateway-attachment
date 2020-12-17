output "private_subnets" {
  value       = module.private.subnets
  description = "The private subnets in the PCA VPC."
}

output "public_subnets" {
  value       = module.public.subnets
  description = "The public subnets in the PCA VPC."
}

output "transit_gateway_id" {
  value       = local.transit_gateway_id
  description = "The ID of the Transit Gateway in the Shared Services account."
}

output "vpc" {
  value       = aws_vpc.pca
  description = "The PCA VPC."
}
