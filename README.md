# S3 Backed for terraform state with Lock in the Dynamo DB

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
| [aws_kms_key.bucket_kms_key](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/kms_key) | resource |
| [aws_s3_bucket.state_bucket](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.example](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_public_access_block.block_public_access](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.example](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.enable_versioning](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_iam_policy_document.bucket_kms_policy](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_user.manager](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/data-sources/iam_user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_bucket_tags"></a> [bucket\_tags](#input\_bucket\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_dynamo_db_name"></a> [dynamo\_db\_name](#input\_dynamo\_db\_name) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
