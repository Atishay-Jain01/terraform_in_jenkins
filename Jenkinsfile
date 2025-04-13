// pipeline {
//     agent any

//     environment {
//         AZURE_CREDENTIALS_ID = '71e9b87d-d066-40af-a412-c479b3326d3c'
//         RESOURCE_GROUP = 'rg-040425'
//         APP_SERVICE_NAME = 'webapijenkins-040425'
//         AZURE_CLI_PATH = 'C:\\Program Files\\Microsoft SDKs\\Azure\\CLI2\\wbin'
//         SYSTEM_PATH = 'C:\\Windows\\System32'
//         TERRAFORM_PATH = 'C:\\Users\\DELL\\Downloads\\terraform_1.11.3_windows_386'
//         DOTNET_PATH = 'C:\\Program Files\\dotnet'
//     }

//     stages {

//         stage('Terraform Init') {
//             steps {
//                 dir('terrafom') {
//                     bat '''
//                         set PATH=%AZURE_CLI_PATH%;%SYSTEM_PATH%;%TERRAFORM_PATH%;%PATH%
//                         terraform init
//                     '''
//                 }
//             }
//         }

//         stage('Terraform Plan & Apply') {
//             steps {
//                 dir('terrafom') {
//                     bat '''
//                         set PATH=%AZURE_CLI_PATH%;%SYSTEM_PATH%;%TERRAFORM_PATH%;%PATH%
//                         terraform plan
//                         terraform apply -auto-approve
//                     '''
//                 }
//             }
//         }

//         stage('Publish .NET 8 Web API') {
//             steps {
//                 dir('webapi') {
//                     // Fix the path setup and use PowerShell
//                     bat '''
//                         PATH=%DOTNET_PATH%;%PATH%
//                         dotnet --version  # Diagnostic step
//                         dotnet restore
//                         dotnet build --configuration Release
//                         dotnet publish -c Release -o out
//                         tar -a -c -f webapi.zip -C out .
//                     '''
//                 }
//             }
//         }

//         stage('Deploy to Azure App Service') {
//             steps {
//                 withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
//                     bat 'set PATH=%AZURE_CLI_PATH%;%SYSTEM_PATH%;%TERRAFORM_PATH%;%PATH%'
//                     bat 'az --version'
//                     bat 'az webapp deploy --resource-group %RESOURCE_GROUP% --name %APP_SERVICE_NAME% --src-path %WORKSPACE%\\webapi\\webapi.zip --type zip'
//                 }
//             }
//         }
//     }

//     post {
//         success {
//             echo 'Deployment Successful!'
//         }
//         failure {
//             echo 'Deployment Failed!'
//         }
//     }
// }

//NEW
pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS_ID = '71e9b87d-d066-40af-a412-c479b3326d3c'
        RESOURCE_GROUP = 'rg-040425'
        APP_SERVICE_NAME = 'webapijenkins-040425'
        AZURE_CLI_PATH = 'C:\\Program Files\\Microsoft SDKs\\Azure\\CLI2\\wbin'
        SYSTEM_PATH = 'C:\\Windows\\System32'  // Just the directory
        TERRAFORM_PATH = 'C:\\Users\\DELL\\Downloads\\terraform_1.11.3_windows_386'
        DOTNET_PATH = 'C:\\Program Files\\dotnet'
    }

    stages {

        stage('Terraform Init') {
            steps {
                dir('terrafom') {
                    bat """
                        where cmd
                        set PATH=%AZURE_CLI_PATH%;%SYSTEM_PATH%;%TERRAFORM_PATH%;%PATH%
                        "C:\\Windows\\System32\\cmd.exe" /c terraform init
                    """
                }
            }
        }

        stage('Terraform Plan & Apply') {
            steps {
                dir('terrafom') {
                    bat """
                        set PATH=%AZURE_CLI_PATH%;%SYSTEM_PATH%;%TERRAFORM_PATH%;%PATH%
                        cmd /c terraform plan
                        cmd /c terraform apply -auto-approve
                    """
                }
            }
        }

        stage('Publish .NET 8 Web API') {
            steps {
                dir('webapi') {
                    bat """
                        set PATH=%DOTNET_PATH%;%PATH%
                        cmd /c dotnet --version
                        cmd /c dotnet restore
                        cmd /c dotnet build --configuration Release
                        cmd /c dotnet publish -c Release -o out
                        cmd /c tar -a -c -f webapi.zip -C out .
                    """
                }
            }
        }

        stage('Deploy to Azure App Service') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: env.AZURE_CREDENTIALS_ID)]) {
                    bat """
                        set PATH=%AZURE_CLI_PATH%;%SYSTEM_PATH%;%TERRAFORM_PATH%;%PATH%
                        cmd /c az --version
                        cmd /c az webapp deploy --resource-group %RESOURCE_GROUP% --name %APP_SERVICE_NAME% --src-path %WORKSPACE%\\webapi\\webapi.zip --type zip
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
