pipeline {
  agent any

    parameters
    {
        booleanParam(defaultValue: true, description: '', name: 'Deploy')
        string(name: 'Environment', defaultValue: "", description: '')
        choice(choices: ['apply', 'destroy'], name: 'Action')
  }
    
  stages {
    stage ('Terraform Init') {
            steps {
                echo "${params.Environment}"
                script {
                    sh "cd ${params.Environment} && terraform init"
                }                
            }
        }
    
        stage ('Terraform Plan') {
            steps {
                script {
                    sh "cd ${params.Environment} && terraform plan"
                }
            }
        }

        stage ('Terraform apply') {
            steps {
                script {
                    sh "cd ${params.Environment} && terraform ${params.Action} -auto-approve"
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
    }
}
