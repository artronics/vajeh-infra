resource "aws_iam_user" "pipeline_user" {
  name = "${var.project.name}_pipeline"
}

resource "aws_iam_user_group_membership" "pipeline_to_deployment" {
  groups = [var.pipeline_group_name]
  user   = aws_iam_user.pipeline_user.name
}
