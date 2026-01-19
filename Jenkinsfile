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
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKERHUB_USER',
            passwordVariable: 'DOCKERHUB_PASS'
        )]) {
            powershell """
                Write-Host "==== Docker Login Output ===="
                echo $Env:DOCKERHUB_PASS | docker login -u $Env:DOCKERHUB_USER --password-stdin

                Write-Host "==== Docker Images Before Push ===="
                docker images

                Write-Host "==== Tagging Image ===="
                docker tag ${Env:IMAGE_NAME}:${Env:BUILD_NUMBER} ${Env:IMAGE_NAME}:latest

                Write-Host "==== Pushing Tagged Images ===="
                docker push ${Env:IMAGE_NAME}:${Env:BUILD_NUMBER}
                docker push ${Env:IMAGE_NAME}:latest

                Write-Host "==== Docker Logout ===="
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
