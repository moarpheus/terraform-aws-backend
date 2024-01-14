data "aws_iam_policy_document" "bucket_kms_policy" {
  statement {
    sid    = "Allow manager to manage key"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [data.aws_iam_user.manager.arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/github_actions_automation"]
    }
    actions = [
      "kms:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "Deny key usage for everyone else"
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]
    condition {
      test     = "StringNotEqualsIfExists"
      variable = "aws:PrincipalArn"
      values   = [data.aws_iam_user.manager.arn]
    }
    condition {
      test     = "StringNotEqualsIfExists"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/github_actions_automation"]
    }
    condition {
      test     = "StringNotEqualsIfExists"
      values   = ["dynamodb.amazonaws.com"]
      variable = "aws:PrincipalServiceName"
    }
  }
}

resource "aws_kms_key" "bucket_kms_key" {
  description             = "This key is used to encrypt state bucket objects"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.bucket_kms_policy.json
}
