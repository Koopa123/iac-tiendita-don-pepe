provider "aws" {
  region = "us-east-2"
}

resource "aws_dynamodb_table" "productos" {
  name           = "Productos"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "Productos"
    Environment = "dev"
  }
}

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

resource "aws_lambda_function" "guardar_producto" {
  function_name = "guardar_producto"
  role          = aws_iam_role.lambda_dynamo_role.arn
  handler       = "index.handler"          # ✅ se mantiene igual
  runtime       = "nodejs18.x"
  filename      = "${path.module}/lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda.zip")

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.productos.name
    }
  }
}

