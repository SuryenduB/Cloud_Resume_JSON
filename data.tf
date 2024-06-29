data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "getResume.py"
  output_path = "getResume.zip"
}