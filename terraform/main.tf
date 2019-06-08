module "pipeline-user" {
  source                = "modules/aws_iam"
  user_name             = "${var.user_name}"
  regenerate_access_key = "${var.regenerate_access_key}"
}

