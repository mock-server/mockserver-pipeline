output "user-id" {
  value = "${aws_iam_user.pipeline-user.id}"
}

output "pipeline-user-access-key-id" {
  value = "${aws_iam_access_key.pipeline-user-key.id}"
}

output "pipeline-user-access-key-secret" {
  value = "${aws_iam_access_key.pipeline-user-key.secret}"
}

output "kube-user-access-key-id" {
  value = "${aws_iam_access_key.kube-user-key.id}"
}

output "kube-user-access-key-secret" {
  value = "${aws_iam_access_key.kube-user-key.secret}"
}
