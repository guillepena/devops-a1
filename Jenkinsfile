pipeline {
    agent any

    environment {
        dockerRegistry = "guillepena94/eoi-devops-a2"
        dockerRegistryCredentialsId = 'dockerhub'
        gitRepository = 'https://github.com/guillepena/devops-a1'
        gitCredentialsId = 'github'
        projectName = 'eoi-devops-a3'
        projectVersion = '1.0'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout Code') {
            steps {
                script{
                    git branch: 'main',
                        credentialsId: gitCredentialsId,
                        url: gitRepository
                }
            }
        }
        stage('Analysis with SonarQube') {
            when {
                expression { return fileExists('sonar-project.properties') }
            }
            steps {
                script {
                    def scannerHome = tool 'SonarQube Scanner'
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build dockerRegistry
                }
            }
        }
        stage('Test Docker Image') {
            steps {
                script {
                    try {
                        sh 'docker run -d --name $projectName $dockerRegistry'
                        sh 'sleep 10'
                        sh 'docker logs $projectName'
                    } finally {
                        sh 'docker rm -f $projectName'
                    }
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('',dockerRegistryCredentialsId) {
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Clean Up') {
            steps {
                script{
                    sh 'docker rmi $dockerRegistry'}
            }
        }
    }
    
    post {
        failure {
            echo 'The pipeline failed'
        }
    }

}