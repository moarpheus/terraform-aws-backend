# Apply run block to create the bucket
run "create_bucket" {
  variables {
    bucket_name = "test-backend-bucket-2023-xyz-me"
    dynamo_db_name = "test-backend_dynamo_db_2023"
    bucket_tags = { "Name": "test-backend-bucket" }
  }

  # Check that the bucket name is correct
  assert {
    condition     = aws_s3_bucket.state_bucket.id == "test-backend-bucket-2023-xyz-me"
    error_message = "Incorrect bucket name"
  }

  assert {
    condition     = aws_s3_bucket.state_bucket.tags_all["Name"] == "test-backend-bucket"
    error_message = "Incorrect tags"
  }
}

