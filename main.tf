resource "aws_s3_bucket" "state_bucket" {
  bucket = var.bucket_name
  tags   = var.bucket_tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_config" {
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

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_config" { #checkov:skip=CKV_AWS_300
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

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
