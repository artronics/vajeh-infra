resource "aws_iam_user" "project_pipeline_user" {
  name = "${local.name_prefix}-pipeline"
}

resource "aws_iam_user_group_membership" "add_pipeline_user" {
  groups = [aws_iam_group.project_pipeline_group.name]
  user = aws_iam_user.project_pipeline_user.name
}
