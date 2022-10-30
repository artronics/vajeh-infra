locals {
  projects = [
    local.auth_project,
  ]
}

module "projects" {
  depends_on             = [module.users, module.auth_policies]
  source                 = "./project"
  count                  = length(local.projects)
  project                = local.projects[count.index]
  root_project           = local.root_project
  permanent_environments = var.permanent_environments
}
