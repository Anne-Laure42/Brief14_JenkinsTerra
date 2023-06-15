pipeline {
  agent any
  environment {
      MY_CRED = credentials('AzureServicePrincipal')
    }
    
  stages {
	  
    stage('Connexion to Azure') {
            steps {
               sh 'az login --service-principal -u $MY_CRED_CLIENT_ID -p $MY_CRED_CLIENT_SECRET -t $MY_CRED_TENANT_ID'
           }
       }

    stage ('Terraform Init') {
        steps {
            script {
                sh "cd StagingEnvironment && terraform init"
            }                
        }
    }

    
    stage ('Terraform Plan') {
        steps {
            script {
                sh "cd StagingEnvironment && terraform plan"
            }
        }
    }

    stage ('Terraform apply') {
        steps {
            script {
                sh "cd StagingEnvironment && terraform apply --auto-approve"
            }    
        }
    } 
    stage('Build Docker image') { 
        steps { 
            checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Anne-Laure42/Brief14_JenkinsTerra']])
            sh 'docker build -t annelaure42/brief14myapp .'
            echo 'Build Image Completed' 
        }
    }
    stage('Login to Docker Hub') {      	
        steps{                       	
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                		
	        echo 'Login Completed'      
        }           
    } 
    stage('Push Image to Docker Hub') {         
        steps{                            
            sh 'sudo docker push annelaure42/brief14myapp'           
            echo 'Push Image Completed'       
        }            
    }

    stage ('Terraform Init2') {
        steps {
            script {
                sh "cd ProdEnvironment && terraform init"
            }                
        }
    }
    
    stage ('Terraform Plan2') {
        steps {
            script {
                sh "cd ProdEnvironment && terraform plan"
            }
        }
    }

    stage ('Terraform apply2') {
        steps {
            script {
                sh "cd ProdEnvironment && terraform apply --auto-approve"
            }    
        }
    } 
  }
}
