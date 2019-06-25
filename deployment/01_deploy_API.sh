#! /bin/bash

## Upload the Lambda function to the S3 bucket that contains artefact
aws s3 cp ./functions/ s3://apps.recommendation.dev.eu-central-1/functions --exclude "*" --include "*.zip" --sse aws:kms --recursive

## package the templates and artefacts
sam package --template-file ./templates/master-fullstack.yaml --output-template-file \
  ./templates/package-template.yaml --s3-bucket apps.recommendation.dev.eu-central-1 --force-upload

## deploy the packaged artefact
sam deploy --template-file ./templates/package-template.yaml  --stack-name PredictorApi \
  --s3-bucket apps.recommendation.dev.eu-central-1 --capabilities CAPABILITY_NAMED_IAM --parameter-overrides ProjectName="predictor"
