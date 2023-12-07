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
                    kubeconfig(caCertificate: '''-----BEGIN CERTIFICATE-----
                                               MIIDBjCCAe6gAwIBAgIBATANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwptaW5p
                                               a3ViZUNBMB4XDTIzMTIwNjA2MzU0MloXDTMzMTIwNDA2MzU0MlowFTETMBEGA1UE
                                               AxMKbWluaWt1YmVDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMtA
                                               zYRm1MefSCZIwgPOY74yU9D4XKbvnbG1ANOOF2eUei5Tx/nAqtC4lf3X90Om6mTm
                                               3mOJ48Wk7BzeJYwqxoq5whZ2b4TCWkP2g3ew1w+Mvk1NtnfF8XckXj5q6uKileiG
                                               ArVrIdwEM+QBR25yWhxFspqX1G70bndo4Qdd/2rnAtSpKeRE40/Ym2tx5U7hr/Ex
                                               c5K4I2C9hcYcOPeIoOEK1ZF1lQbEY0Pl2hq57c3cXdraruBc505P6Dx+p1YvEzpg
                                               F+HnzzdDs3i94WR0yHBFABiojXR7eI21nXmh1Op5kR2oR2aRKzGD14p8BeQNUiJL
                                               nUWnbNUMz7b9SwY66pECAwEAAaNhMF8wDgYDVR0PAQH/BAQDAgKkMB0GA1UdJQQW
                                               MBQGCCsGAQUFBwMCBggrBgEFBQcDATAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQW
                                               BBQz/BRvriS/rh/mqXFbOrAIJbh+JTANBgkqhkiG9w0BAQsFAAOCAQEAvEDqvbbr
                                               ozy12+i/jg2czZUWZ9bgQBae9LXMKnDjQ3g2yk/G0g0isKr3GbMKpEtd0WKzu4X7
                                               oq7emzbyWubQlxNYX9vLgtVJq9LYqT5gCZQUB1t6cUcJ3n5sKrxH0FYYeODgz5F7
                                               c09MNrusxBP2acTvm9tgAGwA477+1uNuC7PSO1iExhCC4MuE0FrcTtN7wLivDMnF
                                               2Yb8/gwgaJb0P3rPOatWfDimI4QN6ffp0Nw0CYDwZbGTLofO1KkdI8NZY4Nqsagl
                                               9TiSRAYRjxLbOJwmYbD1s0+JAdmr9iyeHayIovrWn3NypLKEKuY6a/1eUf9eeubE
                                               P4fB61UzPinFww==
                                               -----END CERTIFICATE-----''', credentialsId: 'kube', serverUrl: 'https://192.168.49.2:8443') {
                        sh "kubectl apply -f spring-kube-deployment.yaml --kubeconfig=${kubeconfig}"
                    }
                }
            }
        }
    }
}
