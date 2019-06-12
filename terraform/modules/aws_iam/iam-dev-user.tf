resource "aws_iam_user" "pipeline-user" {
  name          = "${var.pipeline_user_name}"
  force_destroy = "false"
}

resource "aws_iam_access_key" "pipeline-user-key" {
  user = "${aws_iam_user.pipeline-user.name}"
}

resource "aws_iam_user" "kube-user" {
  name          = "${var.kube_user_name}"
  force_destroy = "false"
}

resource "aws_iam_access_key" "kube-user-key" {
  user = "${aws_iam_user.kube-user.name}"
}
