output "user-id" {
  value = "${aws_iam_user.pipeline-user.id}"
}

output "user-access-key-id" {
  value = "${aws_iam_access_key.pipeline-user-key.*.id}"
}

output "user-access-key-secret" {
  value = "${aws_iam_access_key.pipeline-user-key.*.secret}"
}
