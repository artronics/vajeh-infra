data "aws_iam_user" "developers" {
  for_each = var.project.developers
  user_name = each.key
}

resource "aws_iam_group" "project_developers_group" {
  name = "${local.name_prefix}-developers"
}

resource "aws_iam_user_group_membership" "add_developers" {
  for_each = var.project.developers
  groups = [aws_iam_group.project_developers_group.name]
  user   = each.key
}

resource "aws_iam_group_policy_attachment" "terraform_state_developer_attachment" {
  group      = aws_iam_group.project_developers_group.name
  policy_arn = aws_iam_policy.developers_terraform_state.arn
}

resource "aws_iam_group_policy_attachment" "attach_policies_developer" {
  count = length(var.project.developer_policies)
  group      = aws_iam_group.project_developers_group.name
  policy_arn = var.project.developer_policies[count.index]
}

resource "aws_iam_group" "project_pipeline_group" {
  name = "${local.name_prefix}-pipeline"
}

resource "aws_iam_group_policy_attachment" "terraform_state_pipeline_attachment" {
  group      = aws_iam_group.project_pipeline_group.name
  policy_arn = aws_iam_policy.pipeline_terraform_state.arn
}

resource "aws_iam_group_policy_attachment" "attach_policies_pipeline" {
  count = length(var.project.pipeline_policies)
  group      = aws_iam_group.project_pipeline_group.name
  policy_arn = var.project.pipeline_policies[count.index]
}
