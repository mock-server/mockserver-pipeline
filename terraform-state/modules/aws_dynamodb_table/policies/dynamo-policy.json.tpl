{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": [
        "arn:aws:dynamodb:eu-west-1:${account_id}:table/${table_name}",
        "arn:aws:dynamodb:eu-west-2:${account_id}:table/${table_name}"
      ],
      "Effect": "Allow"
    }
  ]
}