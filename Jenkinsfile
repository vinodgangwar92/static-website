pipeline {
    agent any

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
                sh """
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                """
            }
        }

        stage("Push to Docker Hub") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKERHUB_CREDS}",
                    usernameVariable: "DOCKERHUB_USER",
                    passwordVariable: "DOCKERHUB_PASS"
                )]) {
                    sh """
                        echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
                        docker push ${IMAGE_NAME}:${BUILD_NUMBER}
                        docker push ${IMAGE_NAME}:latest
                        docker logout
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Build #${BUILD_NUMBER} completed"
        }
    }
}
