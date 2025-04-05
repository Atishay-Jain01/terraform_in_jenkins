pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS_ID = '71e9b87d-d066-40af-a412-c479b3326d3c'
        RESOURCE_GROUP = 'rg-040425'
        APP_SERVICE_NAME = 'webapijenkins-040425'
        TERRAFORM_PATH = 'C:\\Users\\DELL\\Downloads\\terraform_1.11.3_windows_386'  // Path to your Terraform executable
    }

    stages {
        stage('Terraform Init') {
            steps {
                dir('terrafom') {
                    bat '%TERRAFORM_PATH%\\terraform init'
                }
            }
        }

        stage('Terraform Plan & Apply') {
            steps {
                dir('terrafom') {
                    bat '%TERRAFORM_PATH%\\terraform plan -out=tfplan'
                    bat '%TERRAFORM_PATH%\\terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Publish .NET 8 Web API') {
            steps {
                dir('webapi') {
                    bat 'dotnet publish -c Release -o out'
                    bat 'powershell Compress-Archive -Path "out\\*" -DestinationPath "webapi.zip" -Force'
                }
            }
        }

        stage('Deploy to Azure App Service') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat '''
                        az login --service-principal -u "%AZURE_CLIENT_ID%" -p "%AZURE_CLIENT_SECRET%" --tenant "%AZURE_TENANT_ID%"
                        az account set --subscription "%AZURE_SUBSCRIPTION_ID%"
                        az webapp deploy --resource-group %RESOURCE_GROUP% --name %APP_SERVICE_NAME% --src-path "%WORKSPACE%\\webapi\\webapi.zip" --type zip
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '''
                =========================================
                Deployment Successful!
                Your application is available at:
                https://%APP_SERVICE_NAME%.azurewebsites.net
                =========================================
            '''
        }
        failure {
            echo '''
                =========================================
                Deployment Failed!
                Please check the logs for details.
                =========================================
            '''
        }
    }
}
