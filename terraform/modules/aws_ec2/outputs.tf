output "public_ip" {
  value = "${aws_eip.instance-ip.public_ip}"
}

output "instance_role_name" {
  value = "${aws_iam_role.instance-role.name}"
}
