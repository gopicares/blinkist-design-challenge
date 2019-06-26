from __future__ import print_function # Python 2/3 compatibility
import os
import boto3
import json

runtime= boto3.client('runtime.sagemaker')
endpoint_param = boto3.client('ssm')

def handler(event, context):
    try:
        print("Received event: " + json.dumps(event, indent=2))
        user = event["body"]["user"]
        test = event["body"]["test"]
        data = json.loads(json.dumps(event["body"]))
        payload = data['data']
        print(payload)
        ## TODO get user category
        ## meantime directly check and route
        
        
        if test != "abtest":
            ssm_ep = endpoint_param.get_parameter(
                Name='SM_PROD_ENDPOINT_NAME'
            )
            ENDPOINT_NAME = ssm_ep["Parameter"].get("Value")
            print(ssm_ep["Parameter"].get("Value"))
            response = runtime.invoke_endpoint(EndpointName=ENDPOINT_NAME,
                                            ContentType='text/csv',
                                            Body=payload
                                            )
            print(response)
            result = json.loads(response['Body'].read().decode())
            print(result)
            pred = int(result['predictions'][0]['score'])
            predicted_label = 'M' if pred == 1 else 'B'
        else:
            predicted_label = 'ABTEST'
        return {
                "statusCode": 200,
                "body": predicted_label
                }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps(str(e))
        }        