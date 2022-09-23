locals {
  aws_policies = [
    "AmazonS3ReadOnlyAccess",
    "IAMFullAccess",
#    "AmazonS3FullAccess",
    "AmazonRoute53FullAccess",
#    "AWSCertificateManagerFullAccess",
    "AmazonRoute53FullAccess",
  ]
}

resource "aws_iam_group" "vajeh_infra_deployment" {
  name = "${local.project}_deployment"
}

resource "aws_iam_user" "vajeh_infra_pipeline" {
  name = "${local.project}_pipeline"
}

resource "aws_iam_user_group_membership" "pipeline_to_deployment" {
  groups = [aws_iam_group.vajeh_infra_deployment.name]
  user   = aws_iam_user.vajeh_infra_pipeline.name
}

data "aws_iam_policy" "aws_policies" {
  count = length(local.aws_policies)
  name     = local.aws_policies[count.index]
}

resource "aws_iam_group_policy_attachment" "attach_aws_policies_to_group" {
  count = length(local.aws_policies)

  group      = aws_iam_group.vajeh_infra_deployment.name
  policy_arn = data.aws_iam_policy.aws_policies[count.index].arn
}
