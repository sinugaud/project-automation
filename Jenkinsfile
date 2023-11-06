pipeline {
    agent any
    tools{
        maven 'MAVEN_HOME'
    }

    stages{
        stage('Build Maven'){
            steps{
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sinugaud/project-automation']])
                sh 'mvn clean install'
            }
        }
        stage('Initialize'){
                    def dockerHome = tool 'docker_dir'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t sinugaud/web-automate .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                   sh 'docker login -u sinugaud -p ${dockerhubpwd}'

}
                   sh 'docker push sinugaud/devops-integration'
                }
            }
        }
    }
}
