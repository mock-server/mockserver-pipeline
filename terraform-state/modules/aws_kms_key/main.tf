resource "aws_kms_key" "key" {
  description = "mockserver-${var.key_name}"

  tags = {
    name = "mockserver-${var.key_name}"
  }

  policy              = "${data.template_file.kms_policy.rendered}"
  enable_key_rotation = true
}

resource "aws_kms_alias" "alias" {
  name          = "alias/mockserver-${var.key_name}"
  target_key_id = "${aws_kms_key.key.key_id}"
}

data "template_file" "kms_policy" {
  template = "${file("${path.module}/policies/key-policy.json.tpl")}"

  vars {
    account_id = "${var.account_id}"
    user_arn   = "${var.user_arn}"
  }
}
