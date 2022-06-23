################################## CREATE STACK ##################################
aws cloudformation create-stack `
--profile default --region us-east-1 `
--stack-name s3-stack `
--template-body file://infra/models/s3.yml

################################## CREATE STACK ##################################
aws cloudformation create-stack `
--profile default --region us-east-1 `
--stack-name lambda-gateway-stack `
--template-body file://infra/models/lambda-gateway.yml `
--capabilities CAPABILITY_NAMED_IAM

################################## VPC AND SUBNETS ##################################
################################## CREATE STACK ##################################

$vpcid=aws ec2 describe-vpcs `
            --query "Vpcs[0].VpcId"

echo $vpcid

$subnets=aws ec2 describe-subnets `
    --filters "Name=vpc-id,Values=${vpcid}" `
    --query "Subnets[*].SubnetId"

echo $subnets

#---------------

aws cloudformation create-stack `
--profile default --region us-east-1 `
--stack-name ci-stack `
--template-body file://infra/models/ci.yml `
--parameters `
    ParameterKey=VpcId,ParameterValue=$vpcid `
    ParameterKey=PrivateSubnets,ParameterValue="subnet-123\,subnet-456\,subnet-7891" `
--capabilities CAPABILITY_NAMED_IAM

################################## UPDATE STACK ##################################
aws cloudformation update-stack `
--profile default --region us-east-1 `
--stack-name s3-stack `
--template-body file://infra/models/s3.yml

################################## UPDATE FUNCTION ##################################
$s3info=aws s3api list-object-versions --bucket src-deploy-aws-calculadora --prefix package.zip --max-items 1 --output json
$x = $s3info | ConvertFrom-Json 
echo $x.Versions[0].VersionId

aws lambda update-function-code `
    --function-name lambda-calculadora `
    --s3-bucket src-deploy-aws-calculadora `
    --s3-key package.zip `
    --s3-object-version $x.Versions[0].VersionId