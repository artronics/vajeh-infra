resource "aws_iam_user" "pipeline_user" {
  name = "${var.project.name}_pipeline"
}

resource "aws_iam_user_group_membership" "pipeline_to_deployment" {
  groups = [aws_iam_group.project_deployment_group.name]
  user   = aws_iam_user.pipeline_user.name
}


