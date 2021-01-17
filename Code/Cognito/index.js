const AmazonCognitoIdentity = require('amazon-cognito-identity-js');
global.fetch = require('node-fetch');

const COGNITO_USER_POOL_ID = "{CHANGE_HERE}";
const COGNITO_APP_CLIENT_ID = "{CHANGE_HERE}";

const login = (userName, password) => {
    return new Promise((resolve, reject) => {
        try 
        {
            var authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails({
                Username: userName,
                Password: password
            });
        
            var poolData = {    
                UserPoolId : COGNITO_USER_POOL_ID,
                ClientId : COGNITO_APP_CLIENT_ID
            }; 
        
            const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);
        
            var userData = {
                Username: userName,
                Pool: userPool
            }
        
            var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);    
        
            //Login
            cognitoUser.authenticateUser(authenticationDetails, {
                onSuccess: function (result) 
                {
                    console.log("onSuccess");

                    var token = {
                        idToken: result.getIdToken().getJwtToken(),
                        accesstoken: result.getAccessToken().getJwtToken(),                        
                        refreshToken: result.getRefreshToken().getToken()
                    };
        
                    resolve({result: token});
                },
                onFailure: function (err) 
                {
                    console.log("onFailure");

                    reject(err);
                },
                newPasswordRequired: function (userAttributes) 
                {
                    //YOU NEED TO CHANGE PASSWORD
                    console.log(cognitoUser.getAuthenticationFlowType(), '=> YOU NEED TO CHANGE PASSWORD');
                    
                    cognitoUser.completeNewPasswordChallenge(
                        password,
                        {name: userName},
                        {
                            onSuccess: (user) => {
                                console.log(JSON.stringify(user));
                                
                                var token =
                                {
                                    idToken: user.idToken.jwtToken,                                    
                                    accesstoken: user.accessToken.jwtToken,
                                    refreshToken: user.refreshToken.token,
                                };


                                resolve({passwordChanged: true, result: token});
                            },
                            onFailure: (error) => {
                                resolve(error);
                            },
                        },
                    );                        
                }
            })    
        }
        catch (error)
        {
            reject(error);
        }
    })        
}

let resultLogin = login("{CHANGE_HERE}", "{CHANGE_HERE}");

resultLogin.then(function(valor) {
    console.log("SUCESO!", valor)
   }, function(motivo) {
    console.log("ERRO!", motivo)
});