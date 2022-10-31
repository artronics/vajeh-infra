locals {
  auth_project_name = "auth"
}

module "auth_policies" {
  source = "./policies"
  root_project = local.root_project
  project_name = local.auth_project_name
  include_envs = var.permanent_environments
  exclude_envs = ["*"]
  services = ["s3", "secretmanager"]
}

locals {
  auth_project = {
    name       = local.auth_project_name
    developers = local.developers
    policies   = module.auth_policies.policies
  }
}
