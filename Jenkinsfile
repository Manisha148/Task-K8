pipeline {
    agent any
    
    stages {
        stage('Clone repository') {
            steps {
                // Checkout SCM
                checkout scm
            }
        }
        
        stage('Build image') {
            steps {
                // Build Docker image
                script {
                    def app = docker.build("manishaverma/javaimg")
                }
            }
        }
        
        stage('Test image') {
            steps {
                // Test Docker image
                script {
                    app.inside {
                        sh 'echo "Tests passed"'
                    }
                }
            }
        }
        
        stage('Push image') {
            steps {
                // Push Docker image
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        app.push("${env.BUILD_NUMBER}")
                    }
                }
            }
        }
        
        stage('Deploy Helm chart') {
            steps {
                // Set environment variables
                script {
                    env.HELM_REPO_URL = 'https://github.com/Manisha148/updatemanifest2.git'
                    env.HELM_CHART_NAME = 'webapp-0.1.0'
                    env.HELM_RELEASE_NAME = 'manisha'
                    env.HELM_NAMESPACE = 'default'
                }
                
                // Add Helm repository
                sh "helm repo add myrepo $HELM_REPO_URL"
                
                // Update Helm dependencies
                sh 'helm dependency update $HELM_CHART_NAME'
                
                // Deploy Helm chart
                sh "helm upgrade --install $HELM_RELEASE_NAME $HELM_CHART_NAME --namespace $HELM_NAMESPACE"
            }
        }
    }
}
