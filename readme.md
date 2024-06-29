# Cloud Resume API Challenge


## Steps 


### Step 1: Create the Dynamo DB as Our No SQL DATABASE using Terraform 


### Step 2: Add Resume Data to the resume database

```zsh
aws dynamodb put-item \
    --table-name resume_json \
    --item file://resume.json

```

### Step 3: Retrieve the Item to verify resume data is correct

```zsh
aws dynamodb get-item \
    --table-name resume_json \
    --key '{"resumeid": {"N": "1"}}' \
    --projection-expression "resumedetails.basics","resumedetails.education","resumedetails.awards","resumedetails.certifications","resumedetails.skills","resumedetails.works"

```

### Step 4: Create the Python Lambda Function using Terraform and Assign Permission to Read the DynamoDB



### Step 5: Create API Gateway , Integrate with the Lambda Function, Create GET Method and Set up CORS