resource "aws_dynamodb_table" "resume_json" {
  name         = "resume_json"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "resumeid"


  attribute {
    name = "resumeid"
    type = "N"
  }


}