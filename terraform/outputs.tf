output "awsKeyId" {
  value = "${module.pipeline-user.user-access-key-id}"
}

output "awsKeySecret" {
  value = "${module.pipeline-user.user-access-key-secret}"
}
