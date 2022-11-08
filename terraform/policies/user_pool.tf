// FIXME: userpool doesn't contain name (only id). This means we can't restrict access based on name and env
// The only solution is to use "Condition" and add "Environment" tag but then, adding the list of users is not possible
// We can't use template either because, terraform template doesn't support for-loops
resource "aws_iam_policy" "cognito_userpool" {
  count  = contains(var.services, "cognito:userpool") ? 1 : 0
  name   = "${var.name_suffix}-cognito_userpool"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "cognito-idp:*",
          "Resource" : "*"
        }
      ]
    }
  )
}

locals {
  cognito_userpool_polices = aws_iam_policy.cognito_userpool.*.arn
}
