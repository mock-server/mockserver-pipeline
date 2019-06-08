#!/usr/bin/env bash

aws kms encrypt --region eu-west-1 --key-id b2263f45-c234-488b-9aaf-bc69130ebe24 --plaintext fileb://terraform-credentials.txt --output text --query CiphertextBlob | base64 --decode > terraform-credentials.enc

aws kms decrypt --region eu-west-1 --ciphertext-blob fileb://terraform-credentials.enc --output text --query Plaintext | base64 --decode > terraform-credentials.dec
