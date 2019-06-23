#! /bin/bash
aws cloudformation --region eu-central-1 create-stack --stack-name test-sagemaker-notebook \
  --template-url https://s3.amazonaws.com/<<your bucket>>/sagemake_notebook_instance.yaml \
  --parameters file://test-sagemaker-params.json \
  --capabilities "CAPABILITY_IAM" \
  --disable-rollback
