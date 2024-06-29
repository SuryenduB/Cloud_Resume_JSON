
resource "aws_lambda_function" "test_lambda" {
  filename         = "getResume.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_for_lambda.arn
  runtime          = "python3.12"
  handler          = "getResume.lambda_handler"
  source_code_hash = data.archive_file.lambda_package.output_base64sha256


}

