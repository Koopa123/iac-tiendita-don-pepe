resource "aws_api_gateway_rest_api" "productos_api" {
  name = "productos-api"
}

resource "aws_api_gateway_resource" "productos" {
  rest_api_id = aws_api_gateway_rest_api.productos_api.id
  parent_id   = aws_api_gateway_rest_api.productos_api.root_resource_id
  path_part   = "productos"
}

resource "aws_api_gateway_method" "post_productos" {
  rest_api_id   = aws_api_gateway_rest_api.productos_api.id
  resource_id   = aws_api_gateway_resource.productos.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_productos" {
  rest_api_id = aws_api_gateway_rest_api.productos_api.id
  resource_id = aws_api_gateway_resource.productos.id
  http_method = aws_api_gateway_method.post_productos.http_method
  integration_http_method = "POST"
  type        = "AWS_PROXY"
  uri         = aws_lambda_function.guardar_producto.invoke_arn
}

resource "aws_lambda_permission" "api_gateway_perm" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.guardar_producto.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.productos_api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "deploy" {
  depends_on = [aws_api_gateway_integration.lambda_productos]
  rest_api_id = aws_api_gateway_rest_api.productos_api.id
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.deploy.id
  rest_api_id   = aws_api_gateway_rest_api.productos_api.id
  stage_name    = "prod"
}

