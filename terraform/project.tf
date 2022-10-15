locals {
  projects = [
    {
      name = "${local.root_project}-app"
    },
    {
      name = "${local.root_project}-auth"
    }
  ]
}

module "project" {
  source = "./project"
  providers = {
    aws.main         = aws.main
    aws.acm_provider = aws.acm_provider
  }

  project = local.projects[0]
  pipeline_group_name = aws_iam_group.vajeh_infra_deployment.name
}
