$BUCKET_NAME="dev-deploy-aws-calculadora"

## Compress and Upload ##
#Compress-Archive -Force -Path src/calculadora/* -DestinationPath package.zip

aws s3 cp package.zip s3://${BUCKET_NAME}/package.zip --profile default

#Remove-Item -Force package.zip