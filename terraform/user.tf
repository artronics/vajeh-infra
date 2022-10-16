locals {
  project_groups = flatten(module.project[*].deployment_groups)
}

locals {
  users = [
    {
      shortname = "jaho",
      groups    = local.project_groups
    }
  ]
}

module "users" {
  source      = "./user"
  count       = length(local.users)
  name_prefix = "vajeh-user"
  user        = local.users[count.index]
}
