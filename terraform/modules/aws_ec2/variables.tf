variable "name" {
  description = "prefix for Name tags"
  type        = "string"
}

variable "ami" {
  // https://aws.amazon.com/marketplace/server/configuration?productId=b7ee8a69-ee97-4a49-9e68-afaee216db2e
  description = "CentOS 7 (x86_64) - with Updates HVM"
  default     = "ami-0ff760d16d9497662"
}

variable "key_path" {
  description = "SSH Public Key path"
  default     = ".ssh/id_rsa.pub"
}

variable "subnet_id" {
  type = "string"
}

variable "security_group_id" {
  type = "string"
}
