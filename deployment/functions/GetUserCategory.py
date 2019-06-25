from __future__ import print_function # Python 2/3 compatibility
import boto3
import json
import os
from boto3.dynamodb.conditions import Key, Attr
from botocore.exceptions import ClientError
dynamodb = boto3.resource("dynamodb", region_name='eu-central-1')

def handler(event,context):
    try:
        user_json = {
            "user": []
        }
        TableName =  dynamodb.Table(os.environ['TABLE_NAME'])
        response = TableName.get_item(
            Key={
                'username': event['pathParameters']['name'],
                'testname': event['queryStringParameters']['test']
            }
        )
        if response.get('Item',0):
            user = response['Item']
            user_json["user"].append(user)
            print("GetUserCategory succeeded:")
            return {
                "statusCode": 200,
                "body": json.dumps(user_json)
            }
        else:
            print("GetUserCategory succeeded: No Data found")
            return {
                "statusCode": 204,
                "body": json.dumps(user_json)
            }
    except Exception as e:
        print("GetUserCategory Failed:")
        return {
            "statusCode": 500,
            "body": json.dumps(str(e))
        }        
