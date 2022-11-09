resource "aws_iam_user" "user" {
  name = var.user.username
  tags = {
    ShortUsername = var.user.short_username
  }
}
