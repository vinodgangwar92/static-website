pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/vinodgangwar92/static-website.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t static-website:latest .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-cred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                bat 'docker tag static-website:latest vinodgangwar92/static-website:latest'
                bat 'docker push vinodgangwar92/static-website:latest'
            }
        }
    }
}
