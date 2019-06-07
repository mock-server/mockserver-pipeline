resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name         = "${var.table_name}"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

data "template_file" "dynamo-iam-policy" {
  template = "${file("${path.module}/policies/dynamo-policy.json.tpl")}"

  vars {
    account_id = "${var.account_id}"
    table_name = "${var.table_name}"
  }
}

resource "aws_iam_policy" "dynamo-iam-policy" {
  name        = "${var.user_name}-dynamodb-${var.table_name}-iam-policy"
  description = "${var.user_name}-dynamodb-${var.table_name}-iam-policy"
  path        = "/"

  policy = "${data.template_file.dynamo-iam-policy.rendered}"
}

resource "aws_iam_user_policy_attachment" "attach-table-policy" {
  user       = "${var.user_name}"
  policy_arn = "${aws_iam_policy.dynamo-iam-policy.arn}"
}
