# IAM role
resource "aws_iam_role" "master-role" {
  name = "${var.cluster_name}-master-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "master-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.master-role.name}"
}

resource "aws_iam_role_policy_attachment" "master-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.master-role.name}"
}

# security group
resource "aws_security_group" "master-sg" {
  name        = "${var.cluster_name}-master-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-master-sg"
  }
}

# OPTIONAL: Allow inbound traffic from your local workstation external IP
#           to the Kubernetes. You will need to replace A.B.C.D below with
#           your real IP. Services like icanhazip.com can help you find this.
resource "aws_security_group_rule" "master-cluster-ingress-workstation-https" {
  cidr_blocks       = ["86.155.1.191/32"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.master-sg.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7
}

# master cluster
resource "aws_eks_cluster" "eks" {
  name     = "${var.cluster_name}"
  role_arn = "${aws_iam_role.master-role.arn}"

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    security_group_ids      = ["${aws_security_group.master-sg.id}"]
    subnet_ids              = ["${var.subnet_ids}"]
    endpoint_private_access = "false"
    endpoint_public_access  = "true"
  }

  depends_on = [
    "aws_cloudwatch_log_group.log_group",
    "aws_iam_role_policy_attachment.master-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.master-cluster-AmazonEKSServicePolicy",
  ]
}
