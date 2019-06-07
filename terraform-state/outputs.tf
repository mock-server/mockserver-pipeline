output "AWS_ACCESS_KEY_ID" {
  value = "${module.terraform-user.user-access-key-id}"
}

output "AWS_SECRET_ACCESS_KEY" {
  value = "${module.terraform-user.user-access-key-secret}"
}

output "credential-encryption-key-id" {
  value = "${module.credential-encryption-key.key-id}"
}