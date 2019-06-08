output "node_role_arn" {
  value = "${aws_iam_role.node-role.arn}"
}

output "security_group_id" {
  value = "${aws_security_group.node-sg.id}"
}

output "node_instance_profile_name" {
  value = "${aws_iam_instance_profile.node-instance-profile.name}"
}
