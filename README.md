# S3 Backend for terraform state with Dynamo DB to hold the lock

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform-lock](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/dynamodb_table) | resource |
| [aws_kms_alias.bucket_kms_key_alias](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.bucket_kms_key](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/kms_key) | resource |
| [aws_s3_bucket.state_bucket](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.lifecycle_config](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_ownership_controls.bucket_ownership](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.state_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.block_public_access](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.encryption_config](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.enable_versioning](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_iam_policy_document.bucket_kms_policy](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.state_bucket_policy_document](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | S3 Bucket name | `string` | n/a | yes |
| <a name="input_bucket_tags"></a> [bucket\_tags](#input\_bucket\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_dynamo_db_name"></a> [dynamo\_db\_name](#input\_dynamo\_db\_name) | Dynamo DB name | `string` | n/a | yes |
| <a name="input_managing_arns"></a> [managing\_arns](#input\_managing\_arns) | Compulsory list of managing principal ARNs to avoid creating un-accessible keys | `list(string)` | n/a | yes |
| <a name="input_principal_arns"></a> [principal\_arns](#input\_principal\_arns) | Compulsory list of principal ARNs that expected to read and write the tf states into the bucket | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
