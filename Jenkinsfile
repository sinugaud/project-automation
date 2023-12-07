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
                    withCredentials([string(credentialsId: 'dockerhub-pw', variable: 'dockerhubpwd')]) {
                        sh "docker login -u sinugaud -p ${dockerhubpwd}"
                        sh 'docker push sinugaud/web-automate'
                    }
                }
            }
        }
        stage('Deploy to k8s') {
            steps {
                script {
                         kubeconfig(credentialsId: 'config', serverUrl: 'https://192.168.49.2:8443') {
                         sh "kubectl apply -f spring-kube-deployment.yaml"
                         }
                    }
                }
            }
        }
    }

