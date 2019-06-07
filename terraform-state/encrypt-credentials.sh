#!/usr/bin/env bash

aws kms encrypt --region eu-west-1 --key-id f2a28f23-96bb-46dc-baa1-7f07177bb96a --plaintext fileb://terraform-credentials.txt --output text --query CiphertextBlob | base64 --decode > terraform-credentials.enc

aws kms decrypt --region eu-west-1 --ciphertext-blob fileb://terraform-credentials.enc --output text --query Plaintext | base64 --decode > terraform-credentials.dec
