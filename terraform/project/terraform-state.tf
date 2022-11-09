locals {
  state_bucket = "${local.name_prefix}-terraform-state"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = local.state_bucket
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

locals {
  dev_include_envs = toset(concat(var.environments.pr_environments, var.environments.developer_environments))
  dev_exclude_envs = toset(var.environments.permanent_environments)
}

resource "aws_iam_policy" "developers_terraform_state" {
  name   = "${local.name_prefix}_developers-terraform-state"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : [
          "arn:aws:s3:::${local.state_bucket}",
        ]
      },
      {
        Action : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ],
        Effect : "Allow",
        "Resource" : [ for e in local.dev_include_envs : "arn:aws:s3:::${local.state_bucket}/env:/${e}/*" ]
      },
      {
        Action : [
          "s3:*",
        ],
        Effect : "Deny",
        "Resource" : [ for e in local.dev_exclude_envs : "arn:aws:s3:::${local.state_bucket}/env:/${e}/*" ]
      }
    ]
  })
}

locals {
  pipeline_include_envs = toset(concat(var.environments.permanent_environments, var.environments.pr_environments))
  pipeline_exclude_envs = toset(var.environments.developer_environments)
}

resource "aws_iam_policy" "pipeline_terraform_state" {
  name   = "${local.name_prefix}_pipeline-terraform-state"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : [
          "arn:aws:s3:::${local.state_bucket}",
        ]
      },
      {
        Action : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ],
        Effect : "Allow",
        "Resource" : [ for e in local.pipeline_include_envs : "arn:aws:s3:::${local.state_bucket}/env:/${e}/*" ]
      },
      {
        Action : [
          "s3:*",
        ],
        Effect : "Deny",
        "Resource" : [ for e in local.pipeline_exclude_envs : "arn:aws:s3:::${local.state_bucket}/env:/${e}/*" ]
      }
    ]
  })
}

