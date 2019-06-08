resource "aws_iam_user" "pipeline-user" {
  name          = "${var.user_name}"
  force_destroy = "false"
}

resource "aws_iam_access_key" "pipeline-user-key" {
  user = "${aws_iam_user.pipeline-user.name}"
}
