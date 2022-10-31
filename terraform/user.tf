locals {
  username_prefix = "${local.root_project}_"
}

module "users" {
  source          = "./user"
  count           = length(var.users)
  username_prefix = local.username_prefix
  user            = var.users[count.index]
}

locals {
  developers = [for dev in var.users : "${local.username_prefix}${dev.username}" if contains(dev.roles, "Developer")]
}
