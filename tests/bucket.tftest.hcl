# Apply run block to create the bucket
run "create_bucket" {
  variables {
    bucket_name = "test-backend-bucket-2023-xyz-me"
    dynamo_db_name = "test-backend_dynamo_db_2023"
    bucket_tags = { "Name": "test-backend-bucket" }
    managing_arns = ["arn:aws:iam::409424458835:user/moarpheus_ui"]
    principal_arns = ["arn:aws:iam::409424458835:role/github_actions_automation"]
  }

  # Check that the bucket name is correct
  assert {
    condition     = aws_s3_bucket.state_bucket.id == "test-backend-bucket-2023-xyz-me"
    error_message = "Incorrect bucket name"
  }

  # Check that the tags are correct
  assert {
    condition     = aws_s3_bucket.state_bucket.tags_all["Name"] == "test-backend-bucket"
    error_message = "Incorrect tags"
  }

  # Check that the encryption configuration is present
  assert {
    condition     = aws_s3_bucket_server_side_encryption_configuration.encryption_config.id == "test-backend-bucket-2023-xyz-me"
    error_message = "No encryption has been configured for the bucket"
  }

  # Check that the bucket versioning is present
  assert {
    condition     = aws_s3_bucket_versioning.enable_versioning.id == "test-backend-bucket-2023-xyz-me"
    error_message = "No versioning has been configured for the bucket"
  }

  # Check that the block public ip is present
  assert {
    condition     = aws_s3_bucket_public_access_block.block_public_access.id == "test-backend-bucket-2023-xyz-me"
    error_message = "No block public ip has been configured for the bucket"
  }

  # Check that the lifecycle configuration ip is present
  assert {
    condition     = aws_s3_bucket_lifecycle_configuration.lifecycle_config.id == "test-backend-bucket-2023-xyz-me"
    error_message = "No lifecycle configuration has been configured for the bucket"
  }

  # Check if Dynamo DB has been created
  assert {
    condition     = aws_dynamodb_table.terraform-lock.id == "test-backend_dynamo_db_2023"
    error_message = "Dynamo DB has not been created correctly"
  }
}
