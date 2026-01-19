pipeline {
    agent {
        label "windows"        // Jenkins node with Windows
    }

    environment {
        DOCKERHUB_CREDS = "dockerhub-creds"  
        IMAGE_NAME = "vinodgangwar92/static-website"
    }

    stages {
        stage("Checkout Code") {
            steps {
                git branch: "main", url: "https://github.com/vinodgangwar92/static-website.git"
            }
        }

        stage("Build Docker Image") {
            steps {
                powershell """
                    docker build -t ${env.IMAGE_NAME}:${env.BUILD_NUMBER} .
                """
            }
        }

        stage("Push to Docker Hub") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: env.DOCKERHUB_CREDS,
                    usernameVariable: "DOCKERHUB_USER",
                    passwordVariable: "DOCKERHUB_PASS"
                )]) {
                    powershell """
                        echo $Env:DOCKERHUB_PASS | docker login -u $Env:DOCKERHUB_USER --password-stdin
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
            echo "Build #${env.BUILD_NUMBER} completed"
        }
    }
}
