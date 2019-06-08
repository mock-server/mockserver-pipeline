variable "cluster_name" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "subnet_ids" {
  type = "list"
}

variable "master_security_group_id" {
  type = "string"
}
