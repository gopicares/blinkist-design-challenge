from __future__ import print_function # Python 2/3 compatibility
import os
import io
import boto3
import json
import csv

runtime= boto3.client('runtime.sagemaker')
endpoint_param = boto3.client('ssm')

    
def handler(event, context):
    try:
        print("Received event: " + json.dumps(event, indent=2))
        
        ssm_ep = endpoint_param.get_parameter(
            Name='SM_PROD_ENDPOINT_NAME'
        )
        ENDPOINT_NAME = ssm_ep["Parameter"].get("Value")
        print(ssm_ep["Parameter"].get("Value"))

        payload = {"instances" : []}
        # for sent in event["body"]:
        #     payload["instances"].append({"data" : sent})    
        # response = runtime.invoke_endpoint(EndpointName=ENDPOINT_NAME,
        #                                    ContentType='application/json',
        #                                    Body=json.dumps(payload))
        # response = response["Body"].read().decode("utf-8")
        # response = json.loads(response)
        # print(response)
        if ENDPOINT_NAME == 'ProdPredictor':
            response = 'Recommendation from Production Instance'
        else:
            response = 'Recommendation from ABTesting Instance'        
        return {
            "statusCode": 200,
            "body": response
            }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps(str(e))
        }        
