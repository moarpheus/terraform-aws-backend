data "aws_iam_policy_document" "state_bucket_policy_document" {
  dynamic "statement" {
    for_each = length(var.managing_arns) > 0 ? [1] : []
    content {
      sid    = "Explicitly allow * for managing arns"
      effect = "Allow"
      principals {
        type        = "AWS"
        identifiers = var.managing_arns
      }
      actions = [
        "s3:*",
      ]
      resources = [
        "arn:aws:s3:::${var.bucket_name}",
        "arn:aws:s3:::${var.bucket_name}/*",
      ]
    }
  }
  dynamic "statement" {
    for_each = length(var.principal_arns) > 0 ? [1] : []
    content {
      sid    = "Explicitly allow getting/updating tfstates for other principal arns"
      effect = "Allow"
      principals {
        type        = "AWS"
        identifiers = var.principal_arns
      }
      actions = [
        "s3:Get*",
        "s3:List*",
        "s3:PutObject"
      ]
      resources = [
        "arn:aws:s3:::${var.bucket_name}",
        "arn:aws:s3:::${var.bucket_name}/*",
      ]
    }
  }
  statement {
    sid    = "core-roles-write-bucket"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
    ]

    condition {
      test     = "ArnNotLike"
      variable = "aws:PrincipalArn"
      values = concat(
        var.principal_arns,
        var.managing_arns
      )
    }
  }
}

resource "aws_s3_bucket_policy" "state_bucket_policy" {
  bucket = aws_s3_bucket.state_bucket.id
  policy = data.aws_iam_policy_document.state_bucket_policy_document.json
}
