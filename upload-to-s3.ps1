$ENVIRONMENT="dev"

Compress-Archive -Force -Path Functions/minhaprimeirafuncao/* -DestinationPath package.zip
aws s3 cp package.zip s3://meu-buckets3/${ENVIRONMENT}/package.zip `
--region us-east-1
Remove-Item -Force package.zip

