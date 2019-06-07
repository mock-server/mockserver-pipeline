resource "aws_iam_user" "pipeline-user" {
  name  = "pipeline-user"
}

resource "aws_iam_access_key" "pipeline-user" {
  user  = "${aws_iam_user.pipeline-user.name}"
}