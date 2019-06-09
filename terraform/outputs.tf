output "awsKeyId" {
  value = "${module.pipeline-user.user-access-key-id}"
}

output "awsKeySecret" {
  value = "${module.pipeline-user.user-access-key-secret}"
}

locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${module.eks_node.node_role_arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
  mapUsers: |
    - userarn: arn:aws:iam::${var.account_id}:user/${var.kube_user_name}
      username: ${var.kube_user_name}
      groups:
        - system:masters
CONFIGMAPAWSAUTH
}

output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}
