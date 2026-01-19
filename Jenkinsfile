pipeline {
    agent any   // Jenkins is already running on Windows

    environment {
        DOCKERHUB_CREDS = "dockerhub-creds"
        IMAGE_NAME = "vinodgangwar92/static-website"
    }

    stages {

        stage("Checkout Code") {
            steps {
                git branch: "main",
                    url: "https://github.com/vinodgangwar92/static-website.git"
            }
        }

        stage("Build Docker Image") {
            steps {
                powershell '''
                    docker version
                    docker build -t vinodgangwar92/static-website:%BUILD_NUMBER% .
                '''
            }
        }

        stage("Push to Docker Hub") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "dockerhub-creds",
                    usernameVariable: "DOCKER_USER",
                    passwordVariable: "DOCKER_PASS"
                )]) {
                    powershell '''
                        echo $Env:DOCKER_PASS | docker login -u $Env:DOCKER_USER --password-stdin
                        docker tag vinodgangwar92/static-website:%BUILD_NUMBER% vinodgangwar92/static-website:latest
                        docker push vinodgangwar92/static-website:%BUILD_NUMBER%
                        docker push vinodgangwar92/static-website:latest
                        docker logout
                    '''
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
