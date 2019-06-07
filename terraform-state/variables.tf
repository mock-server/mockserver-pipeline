variable "account_id" {
  type = "string"
}

variable "user_name" {
  type = "string"
}

variable "state_bucket_name" {
  type = "string"
}

variable "lock_table_name" {
  type = "string"
}

variable "credential_encryption_user_arn" {
  type = "string"
}

variable "regenerate_access_key" {
  default = "false"
}