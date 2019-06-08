resource "aws_iam_user" "terraform-user" {
  name          = "${var.user_name}"
  force_destroy = "false"
}

resource "aws_iam_access_key" "terraform-user-key" {
  count = "${var.regenerate_access_key == "true" ? 1 : 0}"
  user  = "${aws_iam_user.terraform-user.name}"
}

resource "aws_iam_user_policy_attachment" "attach-administrator-policy" {
  user       = "${var.user_name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
