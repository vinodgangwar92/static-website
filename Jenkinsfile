pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = "dockerhub-creds"
        IMAGE_NAME = "vinodgangwar92/static-website"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/vinodgangwar92/static-website.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                powershell """
                  docker version
                  docker build -t ${env.IMAGE_NAME}:${env.BUILD_NUMBER} .
                """
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKERHUB_CREDS}",
                    usernameVariable: "DOCKER_USER",
                    passwordVariable: "DOCKER_PASS"
                )]) {
                    powershell """
                      echo $Env:DOCKER_PASS | docker login -u $Env:DOCKER_USER --password-stdin
                      docker tag ${env.IMAGE_NAME}:${env.BUILD_NUMBER} ${env.IMAGE_NAME}:latest
                      docker push ${env.IMAGE_NAME}:${env.BUILD_NUMBER}
                      docker push ${env.IMAGE_NAME}:latest
                      docker logout
                    """
                }
            }
        }

    }

    post {
        always {
            echo "Build #${env.BUILD_NUMBER} finished"
        }
    }
}
