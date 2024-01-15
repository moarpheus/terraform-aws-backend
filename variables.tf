variable "bucket_tags" {
  type = map(string)
}

variable "bucket_name" {
  description = "S3 Bucket name"
  type        = string
}

variable "dynamo_db_name" {
  description = "Dynamo DB name"
  type        = string
}

variable "managing_arns" {
  description = "Compulsory list of managing principal ARNs to avoid creating un-accessible keys"
  type        = list(string)
}

variable "principal_arns" {
  description = "Compulsory list of principal ARNs that expected to read and write the tf states into the bucket"
  type        = list(string)
}
