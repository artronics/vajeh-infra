module "users" {
  source          = "./user"
  count           = length(var.users)
  user            = var.users[count.index]
}

locals {
  developers = [for dev in var.users : dev.username if contains(dev.roles, "Developer")]
}
