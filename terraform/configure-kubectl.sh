#!/usr/bin/env bash
set -e

# parse AWS credentials
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
credentials_file="${DIR}/terraform-credentials.dec"
if [[ -f "$credentials_file" ]]
then
  echo
  echo "$credentials_file found."

  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval "${key}=\$value"
  done < "$credentials_file"

else
  echo "$credentials_file not found."
fi

if [[ -z "$(command -v aws-iam-authenticator)" ]]; then
  echo
  echo 'Error: aws-iam-authenticator help is not installed' >&2
  echo '  See https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html for instructions' >&2
  echo '  i.e. brew install aws-iam-authenticator' >&2
  echo
  exit 1
fi

eval "AWS_ACCESS_KEY_ID=${awsKeyId} AWS_SECRET_ACCESS_KEY=${awsKeySecret} aws sts get-caller-identity"
eval "AWS_ACCESS_KEY_ID=${awsKeyId} AWS_SECRET_ACCESS_KEY=${awsKeySecret} aws --region eu-west-1 eks update-kubeconfig --name mockserver-eks --alias mockserver-eks"
./deploy worker_nodes_role
./kubectl.sh "apply -f config_map_aws_auth.yaml"
./kubectl.sh "apply -f roles.yaml"
