resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-${local.name_prefix}"
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_policy" "terraform_state" {
  name   = "${local.name_prefix}-terraform-state"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : [
          "arn:aws:s3:::terraform-${local.name_prefix}",
        ]
      },
      {
        Action : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ],
        Effect : "Allow",
        "Resource" : [
          "arn:aws:s3:::terraform-${local.name_prefix}/env:/*",
        ]
      },
      {
        Action : [
          "s3:*",
        ],
        Effect : "Deny",
        "Resource" : [ for e in var.permanent_environments : "arn:aws:s3:::terraform-${local.name_prefix}/env:/${e}/*" ]
      }
    ]
  })
}

