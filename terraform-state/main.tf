module "terraform-user" {
  source = "modules/aws_iam"
  user_name = "${var.user_name}"
  regenerate_access_key = "${var.regenerate_access_key}"
}

module "terraform-remote-state-storage" {
  source = "modules/aws_s3"
  bucket_name = "${var.state_bucket_name}"
  user_name = "${var.user_name}"
}

module "terraform-state-lock" {
  source = "modules/aws_dynamodb_table"
  account_id = "${var.account_id}"
  table_name = "${var.lock_table_name}"
  user_name = "${var.user_name}"
}

module "credential-encryption-key" {
  source = "modules/aws_kms_key"

  key_name     = "credential-encryption-key"
  account_id = "${var.account_id}"
  user_arn     = "${var.credential_encryption_user_arn}"
}