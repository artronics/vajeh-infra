resource "aws_iam_policy" "secretmanager" {
  count  = contains(var.services, "secretmanager") ? 1 : 0
  name   = "${local.project_prefix}-secretmanager"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "secretmanager:*"
          ],
          "Resource" : [for e in var.include_envs : "arn:aws:secretmanager:::${local.project_prefix}-${e}-*"]
        }, {
          "Effect" : "Deny",
          "Action" : [
            "secretmanager:*"
          ],
          "Resource" : [for e in var.exclude_envs : "arn:aws:secretmanager:::${local.project_prefix}-${e}-*"]
        }
      ]
    }
  )
}

locals {
  secretmanager_polices = aws_iam_policy.secretmanager.*.arn
}
