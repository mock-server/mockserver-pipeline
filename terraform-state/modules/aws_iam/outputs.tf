output "user-id" {
  value = "${aws_iam_user.user.id}"
}

output "user-access-key-id" {
  value = "${aws_iam_access_key.user.id}"
}

output "user-access-key-secret" {
  value = "${aws_iam_access_key.user.secret}"
}
