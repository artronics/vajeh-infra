locals {
  vpc_cidr = "10.0.0.0/16"
}

module "network" {
  source = "./network"
  providers = {
    aws.ptl = aws.ptl
  }
  account_name = var.account_name
  vpc_cidr     = local.vpc_cidr
}
