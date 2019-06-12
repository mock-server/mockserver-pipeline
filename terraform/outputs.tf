locals {
  pipeline_credentials = <<CONFIGMAPAWSAUTH


awsKeyId=${module.pipeline-user.pipeline-user-access-key-id}
awsKeySecret=${module.pipeline-user.pipeline-user-access-key-secret}
CONFIGMAPAWSAUTH
}

output "pipeline_credentials" {
  value = "${local.pipeline_credentials}"
}

locals {
  kubernetes_credentials = <<CONFIGMAPAWSAUTH


awsKeyId=${module.pipeline-user.kube-user-access-key-id}
awsKeySecret=${module.pipeline-user.kube-user-access-key-secret}
CONFIGMAPAWSAUTH
}

output "kubernetes_credentials" {
  value = "${local.kubernetes_credentials}"
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
        - mockserver:admin
CONFIGMAPAWSAUTH
}

output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}
