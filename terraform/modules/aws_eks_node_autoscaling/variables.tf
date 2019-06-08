variable "cluster_name" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "subnet_ids" {
  type = "list"
}

variable "kubernetes_version" {
  type = "string"
}

variable "master_apiserver_endpoint" {
  type = "string"
}

variable "cluster_ca_data" {
  type = "string"
}

variable "node_instance_profile_name" {
  type = "string"
}

variable "node_security_group_id" {
  type = "string"
}
