module "network" {
  source    = "./network"
  providers = {
    aws.ptl = aws.ptl
  }
  account_name = var.account_name
}
