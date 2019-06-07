output "awsKeyId" {
  value = "${module.terraform-user.user-access-key-id}"
}

output "awsKeySecret" {
  value = "${module.terraform-user.user-access-key-secret}"
}

output "credentialEncryptionKeyId" {
  value = "${module.credential-encryption-key.key-id}"
}