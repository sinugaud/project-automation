pipeline {
    agent any
    tools {
        maven 'MAVEN_HOME'
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout scm
                sh 'mvn clean install'
            }
        }
        stage('Initialize') {
            steps {
                script {
                    def dockerHome = tool name: 'docker_dir', type: 'Tool'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
        stage('Build docker image') {
            steps {
                script {
                    sh 'docker build -t sinugaud/web-automate .'
                }
            }
        }
        stage('Push image to Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                        sh "docker login -u sinugaud -p ${dockerhubpwd}"
                        sh 'docker push sinugaud/web-automate'
                    }
                }
            }
        }
    }
}
