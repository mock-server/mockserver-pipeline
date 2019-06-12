#!/usr/bin/env bash
set -e

# parse AWS credentials
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
credentials_file="${DIR}/terraform-credentials.dec"
#credentials_file="${DIR}/kubernetes-credentials.dec"
if [[ -f "$credentials_file" ]]
then
  echo "$credentials_file found."

  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval "${key}=\$value"
  done < "$credentials_file"

else
  echo "$credentials_file not found."
fi

eval "AWS_ACCESS_KEY_ID=${awsKeyId} AWS_SECRET_ACCESS_KEY=${awsKeySecret} aws sts get-caller-identity"
eval "AWS_ACCESS_KEY_ID=${awsKeyId} AWS_SECRET_ACCESS_KEY=${awsKeySecret} kubectl --context mockserver-eks ${1}"
