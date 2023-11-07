pipeline {
    agent any
    tools {
        maven 'MAVEN_HOME'
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout scm
                bat 'mvn clean install'
            }
        }
        stage('Build docker image') {
            steps {
                script {
                    bat 'docker build -t sinugaud/web-automate .'
                }
            }
        }
        stage('Push image to Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                        bat "docker login -u sinugaud -p ${dockerhubpwd}"
                        bat 'docker push sinugaud/web-automate'
                    }
                }
            }
        }
    }
}
