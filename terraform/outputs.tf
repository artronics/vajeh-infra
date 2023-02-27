output "vpc_id" {
  value = module.network.vpc_id
}

output "vpc_cidr" {
  value = local.vpc_cidr
}
