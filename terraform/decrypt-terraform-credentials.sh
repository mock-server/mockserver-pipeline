#!/usr/bin/env bash

aws kms decrypt --region eu-west-1 --ciphertext-blob fileb://terraform-credentials.enc --output text --query Plaintext | base64 --decode > terraform-credentials.dec
