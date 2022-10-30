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
      aws_policies = [
        "AWSCertificateManagerFullAccess",
        "AmazonRoute53FullAccess",
        "AmazonCognitoPowerUser"
      ]
    },
    {
      name         = "${local.root_project}-auth"
      aws_policies = [
        "AmazonCognitoPowerUser",
        "AmazonRoute53FullAccess",
        "AWSCertificateManagerFullAccess",
        "CloudFrontFullAccess",
        "SecretsManagerReadWrite",
      ]
    },
    {
      name         = "${local.root_project}-api"
      aws_policies = [
        "AmazonRoute53FullAccess",
        "AWSCertificateManagerFullAccess",
        "AWSAppSyncAdministrator",
        "AWSAppSyncSchemaAuthor"
      ]
    },
    {
      name         = "${local.root_project}-user"
      aws_policies = [
        "AmazonEC2ContainerRegistryFullAccess",
        "AWSLambda_FullAccess",
        "AWSLambdaRole",
        "SecretsManagerReadWrite",
      ]
    }
  ]
}

locals {
  default_aws_policies = [
    "AmazonS3FullAccess",
    "CloudWatchFullAccess",
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
