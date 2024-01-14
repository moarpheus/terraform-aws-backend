data "aws_iam_user" "manager" {
  user_name = "moarpheus_ui"
}

data "aws_caller_identity" "current" {}
