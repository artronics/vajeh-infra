locals {
  vpc_cidr = "10.0.0.0/16"
  platform_cidr = "10.0.10.0/24"
}

module "network" {
  source = "./network"
  providers = {
    aws.ptl = aws.ptl
  }
  account_name = var.account_name
  vpc_cidr     = local.vpc_cidr
  platform_cidr = local.platform_cidr
}
