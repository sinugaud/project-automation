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
                 def kubeconfig = readFile 'spring-kube-deployment.yaml'  // Read kubeconfig if necessary
                             sh "kubectl apply -f spring-kube-deployment.yaml --kubeconfig=${kubeconfig}"


                    }
                }
            }
        }
    }
}
