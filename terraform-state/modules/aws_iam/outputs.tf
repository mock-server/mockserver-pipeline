output "user-id" {
  value = "${aws_iam_user.terraform-user.id}"
}

output "user-access-key-id" {
  value = "${aws_iam_access_key.terraform-user-key.*.id}"
}

output "user-access-key-secret" {
  value = "${aws_iam_access_key.terraform-user-key.*.secret}"
}
