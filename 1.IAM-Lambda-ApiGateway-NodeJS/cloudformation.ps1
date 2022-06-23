################################## CREATE ##################################
aws cloudformation create-stack `
--profile default --region us-east-1 `
--stack-name s3-stack `
--template-body file://infra/models/s3.yml `
--parameters `
    ParameterKey=ENV,ParameterValue=dev

aws cloudformation create-stack `
--profile default --region us-east-1 `
--stack-name lambda-stack `
--template-body file://infra/models/lambda.yml `
--parameters `
    ParameterKey=ENV,ParameterValue=dev `
--capabilities CAPABILITY_NAMED_IAM

aws cloudformation create-stack `
--profile default --region us-east-1 `
--stack-name apigateway-stack `
--template-body file://infra/models/apigateway.yml `
--parameters `
    ParameterKey=LAMBDAARN,ParameterValue={ARN_HERE} `
--capabilities CAPABILITY_NAMED_IAM

################################## UPDATE ##################################
aws cloudformation update-stack `
--profile default --region us-east-1 `
--stack-name MY_STACK_NAME `
--template-body file://infra/models/STACK_FILENAME.yml `
--parameters `
    ParameterKey=ENV,ParameterValue=dev `
--capabilities CAPABILITY_NAMED_IAM

################################## DELETE ##################################
aws s3 rm s3://dev-deploy-aws-calculadora/package.zip

aws cloudformation delete-stack --stack-name s3-stack
aws cloudformation delete-stack --stack-name lambda-stack
aws cloudformation delete-stack --stack-name apigateway-stack