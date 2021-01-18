$ENVIRONMENT="dev"

## Compress and Upload

Compress-Archive -Force -Path Functions/minhaprimeirafuncao/* -DestinationPath package.zip
aws s3 cp package.zip s3://meu-buckets3/${ENVIRONMENT}/package.zip `
--profile felipe --region us-east-1
Remove-Item -Force package.zip

## Upload
aws s3 cp Models/s3.yml s3://hmg-meubuckets3/s3.yml `
--profile felipe --region us-east-1