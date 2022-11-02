locals {
  auth_project_name = "auth"
  auth_project_team       = local.developers # all devs

  auth_project_conf = {
    name       = local.auth_project_name
    developer_envs = local.developers_environments
    suffix     = "${local.root_project}-${local.auth_project_name}"
    services   = ["s3", "secretsmanager"]
  }
}


#module "auth_developer_policies" {
#  source       = "./policies"
#  root_project = local.root_project
#  project_name = local.auth_project_conf.name
#  services     = local.auth_project_conf.services
#
#  name_suffix  = "${local.auth_project_conf.suffix}-developer"
#  include_envs = concat(var.pr_environments, var.ptl_environments, local.auth_project_conf.developer_envs)
#  exclude_envs = var.permanent_environments
#}
#
#module "auth_pipeline_policies" {
#  source       = "./policies"
#  root_project = local.root_project
#  project_name = local.auth_project_conf.name
#  services     = local.auth_project_conf.services
#
#  name_suffix  = "${local.auth_project_conf.suffix}-pipeline"
#  include_envs = concat(var.pr_environments, var.ptl_environments, var.permanent_environments)
#  exclude_envs = local.auth_project_conf.developer_envs
#}

locals {
  auth_project = {
    name               = local.auth_project_name
    developers         = local.auth_project_team
#    developer_policies = module.auth_developer_policies.policies
#    pipeline_policies  = module.auth_pipeline_policies.policies
  }
}
