resource "aws_iam_user" "user" {
  name = "${local.name_prefix}${var.user.username}"
  tags = {
    ShortUsername = var.user.short_username
  }
}
