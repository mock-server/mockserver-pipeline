resource "aws_iam_user" "user" {
  name  = "${var.user_name}"
  force_destroy = "false"
}

resource "aws_iam_access_key" "user" {
  count        = "${var.regenerate_access_key == "true" ? 1 : 0}"
  user  = "${aws_iam_user.user.name}"
}
