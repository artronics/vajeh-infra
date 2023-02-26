locals {
  public_subnet = [
  ]
  private_subnet = [
    {
      cidr              = cidrsubnet(local.vpc_cidr, 8, 101)
      availability_zone = "eu-west-2a"
      is_public         = false
    }
  ]
}

