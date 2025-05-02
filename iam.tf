resource "aws_iam_role" "lambda_dynamo_role" {
  name = "lambda_dynamo_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_dynamo_policy" {
  name       = "lambda_dynamo_policy"
  roles      = [aws_iam_role.lambda_dynamo_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}
