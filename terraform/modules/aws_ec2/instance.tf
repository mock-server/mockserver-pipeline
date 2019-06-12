# key pair for our instance SSH access
resource "aws_key_pair" "key_pair" {
  key_name   = "${var.name}-ec2-keypair"
  public_key = "${file("${path.module}/${var.key_path}")}"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.tpl")}"
  vars     = {}
}

resource "aws_instance" "instance" {
  ami                         = "${var.ami}"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.key_pair.id}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${var.security_group_id}"]
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = "${data.template_file.user_data.rendered}"
  iam_instance_profile        = "${aws_iam_instance_profile.instance-profile.name}"

  tags {
    Name = "${var.name}-host"
  }
}

resource "aws_eip" "instance-ip" {
  instance = "${aws_instance.instance.id}"
  vpc      = true

  tags {
    Name = "${var.name}-host-ip"
  }
}

resource "aws_iam_role" "instance-role" {
  name = "${var.name}-host-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "${var.name}-ec2-profile"
  role = "${aws_iam_role.instance-role.name}"
}
