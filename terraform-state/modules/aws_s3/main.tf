resource "aws_s3_bucket" "terraform-state-storage" {
  bucket = "${var.bucket_name}"
  acl = "private"
  force_destroy = "false"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }

  tags {
    Name = "${var.bucket_name}"
  }
}

data "template_file" "dynamo-iam-policy" {
  template = "${file("${path.module}/policies/s3-policy.json.tpl")}"

  vars {
    bucket_name = "${var.bucket_name}"
  }
}

resource "aws_iam_policy" "s3-iam-policy" {
  name        = "${var.user_name}-s3-${var.bucket_name}-iam-policy"
  description = "${var.user_name}-s3-${var.bucket_name}-iam-policy"
  path        = "/"

  policy = "${data.template_file.dynamo-iam-policy.rendered}"
}

resource "aws_iam_user_policy_attachment" "attach-bucket-policy" {
  user       = "${var.user_name}"
  policy_arn = "${aws_iam_policy.s3-iam-policy.arn}"
}
