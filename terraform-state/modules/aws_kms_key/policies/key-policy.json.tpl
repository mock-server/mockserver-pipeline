{
  "Version": "2012-10-17",
  "Id": "key-management-storage-key-encryption-key-policy",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow use of key for encrypting/decrypting storage keys",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${user_arn}"
        ]
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt"
      ],
      "Resource": "*"
    }
  ]
}