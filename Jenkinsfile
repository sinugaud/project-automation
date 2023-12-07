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
                        sh "sudo docker login -u sinugaud -p ${dockerhubpwd}"
                        sh 'sudo docker push sinugaud/web-automate'
                    }
                }
            }
        }
        stage('Deploy to k8s'){
                    steps{
                        script{
                            kubernetesDeploy (configs: 'spring-kube-deployment.yaml')
                        }
                    }
                }
    }
}
