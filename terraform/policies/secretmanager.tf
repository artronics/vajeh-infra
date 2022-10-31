resource "aws_iam_policy" "secretsmanager" {
  count  = contains(var.services, "secretsmanager") ? 1 : 0
  name   = "${var.name_suffix}-secretsmanager"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "secretsmanager:*"
          ],
          "Resource" : [for e in var.include_envs : "arn:aws:secretsmanager:*:*:secret:${var.root_project}/${var.project_name}/${e}/*"]
        }, {
          "Effect" : "Deny",
          "Action" : [
            "secretsmanager:*"
          ],
          "Resource" : [for e in var.exclude_envs : "arn:aws:secretsmanager:*:*:secret:${var.root_project}/${var.project_name}/${e}/*"]
        }
      ]
    }
  )
}

locals {
  secretsmanager_polices = aws_iam_policy.secretsmanager.*.arn
}
