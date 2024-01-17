data "aws_iam_policy_document" "bucket_kms_policy" {
  statement {
    sid    = "List of principal ARNs to manage bucket key"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = var.managing_arns
    }
    actions = [
      "kms:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "List of principal ARNs to use bucket key"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = var.principal_arns
    }
    actions = [
      "kms:DescribeKey",
      "kms:Decrypt",
      "kms:GenerateDataKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:ListResourceTags"
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
      "kms:DescribeKey",
      "kms:Decrypt",
      "kms:GenerateDataKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:ListResourceTags"
    ]
    resources = ["*"]
    condition {
      test     = "StringNotEqualsIfExists"
      variable = "aws:PrincipalArn"
      values   = concat(var.managing_arns, var.principal_arns)
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

resource "aws_kms_alias" "bucket_kms_key_alias" {
  name          = "alias/${var.bucket_name}-kms-key-alias"
  target_key_id = aws_kms_key.bucket_kms_key.key_id
}
