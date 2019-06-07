output "pipeline-user-access-key-id" {
  value = "${aws_iam_access_key.pipeline-user.*.id}"
}

output "pipeline-user-access-key-secret" {
  value = "${aws_iam_access_key.pipeline-user.*.secret}"
}
