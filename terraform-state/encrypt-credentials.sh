#!/usr/bin/env bash

aws kms encrypt --region eu-west-1 --key-id c73da5cc-8ab7-404e-8257-ac567eda7e94 --plaintext fileb://terraform-credentials.txt --output text --query CiphertextBlob | base64 --decode > terraform-credentials.enc

aws kms decrypt --region eu-west-1 --ciphertext-blob fileb://terraform-credentials.enc --output text --query Plaintext | base64 --decode > terraform-credentials.dec
