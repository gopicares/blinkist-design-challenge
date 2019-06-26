## Delete the instance
aws cloudformation delete-stack --stack-name DemoSagemakerNotebook

## Delete the endpoint
aws cloudformation delete-stack --stack-name DemoSagemakerEndpoint

## delete the stack
aws cloudformation delete-stack --stack-name PredictorApi
