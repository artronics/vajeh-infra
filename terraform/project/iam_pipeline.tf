resource "aws_iam_user" "pipeline_user" {
  name = "${var.project.name}_pipeline"
}

resource "aws_iam_user_group_membership" "pipeline_to_deployment" {
  groups = [var.pipeline_group_name]
  user   = aws_iam_user.pipeline_user.name
}

resource "aws_iam_user_policy_attachment" "pipeline_user_policies" {
  count = length(var.project.pipeline_existing_policies)
  policy_arn = data.aws_iam_policy.aws_policies[count.index].arn
  user       = aws_iam_user.pipeline_user.name
}

data "aws_iam_policy" "aws_policies" {
  count = length(var.project.pipeline_existing_policies)
  name  = var.project.pipeline_existing_policies[count.index]
}
