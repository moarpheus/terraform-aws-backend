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
