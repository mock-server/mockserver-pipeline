module "pipeline-user" {
  source    = "modules/aws_iam"
  pipeline_user_name = "${var.pipeline_user_name}"
  kube_user_name = "${var.kube_user_name}"
}

module "eks_vpc" {
  source       = "modules/aws_vpc"
  cluster_name = "${var.cluster_name}"
}

module "eks_master" {
  source       = "modules/aws_eks_master"
  cluster_name = "${var.cluster_name}"
  vpc_id       = "${module.eks_vpc.vpc_id}"
  subnet_ids   = "${module.eks_vpc.subnet_ids}"
}

module "eks_node" {
  source                   = "modules/aws_eks_node"
  cluster_name             = "${var.cluster_name}"
  vpc_id                   = "${module.eks_vpc.vpc_id}"
  subnet_ids               = "${module.eks_vpc.subnet_ids}"
  master_security_group_id = "${module.eks_master.security_group_id}"
}

module "eks_node_autoscaling" {
  source                     = "modules/aws_eks_node_autoscaling"
  cluster_name               = "${var.cluster_name}"
  vpc_id                     = "${module.eks_vpc.vpc_id}"
  subnet_ids                 = "${module.eks_vpc.subnet_ids}"
  kubernetes_version         = "${module.eks_master.kubernetes_version}"
  master_apiserver_endpoint  = "${module.eks_master.master_apiserver_endpoint}"
  cluster_ca_data            = "${module.eks_master.cluster_ca_data}"
  node_instance_profile_name = "${module.eks_node.node_instance_profile_name}"
  node_security_group_id     = "${module.eks_node.security_group_id}"
}
