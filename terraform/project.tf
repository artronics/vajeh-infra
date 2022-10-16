locals {
  projects = [
    {
      name         = "${local.root_project}-infra"
      aws_policies = [
        "IAMFullAccess",
        "AmazonRoute53FullAccess",
      ]
    },
    {
      name         = "${local.root_project}-app"
      aws_policies = ["AWSCertificateManagerFullAccess","AmazonRoute53FullAccess"]
    },
    {
      name         = "${local.root_project}-auth"
      aws_policies = ["AmazonCognitoPowerUser"]
    }
  ]
}

locals {
  default_aws_policies = [
    "AmazonS3FullAccess",
  ]
}

module "project" {
  source    = "./project"
  providers = {
    aws.main         = aws.main
    aws.acm_provider = aws.acm_provider
  }

  count                = length(local.projects)
  project              = local.projects[count.index]
  default_aws_policies = local.default_aws_policies
}
