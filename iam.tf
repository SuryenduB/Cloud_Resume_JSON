data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "lambda_dynamodb" {
  statement {
    effect = "Allow"

    actions = [

      "dynamodb:PutItem",

      "dynamodb:GetItem",
      "dynamodb:Scan"
    ]

    resources = [aws_dynamodb_table.resume_json.arn]
  }
}

resource "aws_iam_policy" "lambda_dynamodb" {
  name        = "lambda_dynamodb"
  path        = "/"
  description = "IAM policy for managing dynamodb items"
  policy      = data.aws_iam_policy_document.lambda_dynamodb.json
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_dynamodb.arn
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.iam_for_lambda.name
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.readResume.execution_arn}/*/*/*"
}
