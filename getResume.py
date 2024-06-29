import boto3
import json

def lambda_handler(event, context):
    dynamodb = boto3.client('dynamodb')
    table_name = 'resume_json'  # Replace with your actual table name
    
    # Get the item in DynamoDB
    key = {
        'resumeid': {'N': '1'}  # Replace '1' with the actual attribute value if needed
    }
    
    response = dynamodb.get_item(TableName=table_name,Key=key,ProjectionExpression='resumedetails.basics, resumedetails.education, resumedetails.certifications, resumedetails.skills, resumedetails.works')
    
    
    resume_details = response.get('Item').get('resumedetails')

    return {
        
        'resume_details': json.dumps(resume_details)
    }