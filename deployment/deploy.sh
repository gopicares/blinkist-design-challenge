####################################
# Step 1: Data Collection Pipeline:
####################################

####################################
# Step 2: Data Science Pipeline:
####################################

## Deploy a notebook instances
sam deploy --template-file ./resources/cfn_sagemaker_notebook.yaml  --stack-name DemoSagemakerNotebook \
  --s3-bucket apps.recommendation.dev.eu-central-1 --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides NotebookInstanceType="ml.t2.medium" NotebookInstanceName="TestNotebookInstance"

## Host a pre-trained model
sam deploy --template-file ./resources/cfn_sagemaker_endpoint.yaml  --stack-name DemoSagemakerEndpoint\
--s3-bucket apps.recommendation.dev.eu-central-1 --capabilities CAPABILITY_NAMED_IAM 

####################################
# Step 3: Model Inference Pipeline:
####################################

## Upload the Lambda function to the S3 bucket that contains artefact
aws s3 cp ./functions/ s3://apps.recommendation.dev.eu-central-1/functions --exclude "*" --include "*.zip" --sse aws:kms --recursive

## package the deployment
sam package --template-file ./templates/master-fullstack.yaml \
  --output-template-file ./templates/package-template.yaml \
  --s3-bucket apps.recommendation.dev.eu-central-1 --force-upload

## deploy the deployment
sam deploy --template-file ./templates/package-template.yaml  \
  --stack-name PredictorApi --s3-bucket apps.recommendation.dev.eu-central-1 \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides ProjectName="predictor"



