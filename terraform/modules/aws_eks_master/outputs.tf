output "security_group_id" {
  value = "${aws_security_group.master-sg.id}"
}

output "kubernetes_version" {
  value = "${aws_eks_cluster.eks.version}"
}

output "master_apiserver_endpoint" {
  value = "${aws_eks_cluster.eks.endpoint}"
}

output "cluster_ca_data" {
  value = "${aws_eks_cluster.eks.certificate_authority.0.data}"
}
