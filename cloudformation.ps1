######## CREATE ########

aws cloudformation create-stack `
--profile felipe --region us-east-1 `
--stack-name felipedev `
--template-body file://Models/infra.yml `
--parameters `
    ParameterKey=ENV,ParameterValue=dev `
    ParameterKey=KeyPair,ParameterValue=felipeaws `
--capabilities CAPABILITY_NAMED_IAM

######## UPDATE ########

aws cloudformation update-stack `
--profile felipe --region us-east-1 `
--stack-name felipedev `
--template-body file://Models/infra.yml `
--parameters `
    ParameterKey=ENV,ParameterValue=dev `
    ParameterKey=KeyPair,ParameterValue=felipeaws `
--capabilities CAPABILITY_NAMED_IAM

######## CHANGE SET ########

aws cloudformation create-change-set `
--profile felipe --region us-east-1 `
--stack-name felipedev `
--template-body file://Models/infra.yml `
--parameters `
        ParameterKey=ENV,ParameterValue=dev `
        ParameterKey=KeyPair,ParameterValue=felipeaws `
--change-set-name changeset-1


aws cloudformation describe-change-set `
--profile felipe --region us-east-1 `
--stack-name felipedev `
--change-set-name changeset-1

aws cloudformation execute-change-set `
--profile felipe --region us-east-1 `
--stack-name felipedev `
--change-set-name changeset-1

