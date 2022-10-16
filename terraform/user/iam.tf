resource "aws_iam_user" "user" {
  name = "${var.name_prefix}_${var.user.shortname}"
}

resource "aws_iam_user_group_membership" "add_user_to_group" {
  groups = var.user.groups
  user   = aws_iam_user.user.name
}
