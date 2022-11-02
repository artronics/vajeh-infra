#module "users" {
#  source          = "./user"
#  count           = length(var.users)
#  username_prefix = local.username_prefix
#  user            = var.users[count.index]
#}

locals {
  developers = [for dev in var.users : dev.username if contains(dev.roles, "Developer")]
}
