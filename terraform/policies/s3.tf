resource "aws_iam_policy" "s3" {
  count  = contains(var.services, "s3") ? 1 : 0
  name   = "${local.project_prefix}-s3"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:*"
          ],
          "Resource" : [for e in var.include_envs : "arn:aws:s3:::${local.project_prefix}-${e}-*"]
        }, {
          "Effect" : "Deny",
          "Action" : [
            "s3:*"
          ],
          "Resource" : [for e in var.exclude_envs : "arn:aws:s3:::${local.project_prefix}-${e}-*"]
        }
      ]
    }
  )
}

locals {
  s3_polices = aws_iam_policy.s3.*.arn
}
