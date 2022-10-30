resource "aws_iam_user" "test-user" {
  name = "vajeh-iam-test-user"
}

resource "aws_iam_group" "test-group" {
  name = "vajeh-iam-test-user"
}

resource "aws_iam_user_group_membership" "add_user_to_group" {
  groups = [aws_iam_group.test-group.name]
  user   = aws_iam_user.test-user.name
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  prj = {
    name     = "vajeh-user"
    tf_state = "terraform-vajeh-user"
  }
}

resource "aws_iam_policy" "terraform_state" {
  name   = "vajeh-test-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ],
        Effect : "Allow",
        "Resource" : [
          "arn:aws:s3::${local.account_id}:terraform-${local.prj["name"]}/*",
        ]
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "policy_at" {
  group      = aws_iam_group.test-group.name
  policy_arn = aws_iam_policy.terraform_state.arn
}

