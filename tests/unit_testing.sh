#! /bin/bash

## testing creation of notebook instance
aws cloudformation --region eu-central-1 create-stack --stack-name test-sagemaker-notebook \
  --template-url https://s3.amazonaws.com/<<your bucket>>/sagemake_notebook_instance.yaml \
  --parameters file://test-sagemaker-params.json \
  --capabilities "CAPABILITY_IAM" \
  --disable-rollback

# aws cloudformation delete-stack --stack-name SagemakerNotebook

## testing creation of endpoint based on bring your model
sam deploy --template-file ./resources/cfn_sagemaker_endpoint.yaml  --stack-name DemoSagemakerEndpoint \
  --s3-bucket apps.recommendation.dev.eu-central-1 
  --capabilities CAPABILITY_NAMED_IAM 

# aws cloudformation delete-stack --stack-name DemoSagemakerEndpoint

## Deploy API for Predictor Inferences
sam package --template-file ./templates/master-fullstack.yaml \
  --output-template-file ./templates/package-template.yaml \
  --s3-bucket apps.recommendation.dev.eu-central-1 --force-upload
  
sam deploy --template-file ./templates/package-template.yaml  --stack-name PredictorApi \
  --s3-bucket apps.recommendation.dev.eu-central-1 \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides ProjectName="predictor"

# aws cloudformation delete-stack --stack-name PredictorApi



