resource "aws_iam_group" "project_deployment_group" {
  name = "${var.project.name}_deployment"
}

locals {
  project_policies= setunion(var.project.aws_policies, var.default_aws_policies)
}

data "aws_iam_policy" "aws_policies" {
  for_each = local.project_policies
  name  = each.key
}

resource "aws_iam_group_policy_attachment" "group_policies" {
#  count = length(data.aws_iam_policy.aws_policies)
  for_each = data.aws_iam_policy.aws_policies
#  policy_arn = data.aws_iam_policy.aws_policies[count.index].arn
  policy_arn = each.value.arn
  group       = aws_iam_group.project_deployment_group.name
}

