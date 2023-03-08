output "vpc_id" {
  value = module.network.vpc_id
}

output "vpc_default_security_group" {
  value = module.network.vpc_default_security_group
}

output "vpc_cidr" {
  value = local.vpc_cidr
}

output "platform_subnet_ids" {
  value = module.network.platform_subnet_ids
}

output "terraform_plugin_cache_efs_access_point" {
  value = aws_efs_access_point.terraform_plugin_cache_efs_access_point.arn
}
