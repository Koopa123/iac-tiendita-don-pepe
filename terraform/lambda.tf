resource "aws_lambda_function" "guardar_producto" {
  function_name    = "guardar_producto"
  role             = aws_iam_role.lambda_dynamo_role.arn
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  filename         = "${path.module}/lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda.zip")

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.productos.name
    }
  }
}
