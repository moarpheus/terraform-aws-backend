resource "aws_s3_bucket" "state_bucket" {
  bucket = var.bucket_name
  tags   = var.bucket_tags
}

resource "aws_kms_key" "bucket_kms_key" {
  description             = "This key is used to encrypt state bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.bucket_kms_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.bucket_kms_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "enable_versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_lifecycle_configuration" "example" { #checkov:skip=CKV_AWS_300
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    id = "incomplete multipart uploads"
    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
    filter {
      prefix = ""
    }
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-lock" {
  name           = var.dynamo_db_name
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.bucket_kms_key.arn
  }
  point_in_time_recovery {
    enabled = true
  }
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}
