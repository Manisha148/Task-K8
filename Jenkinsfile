// pipeline {
//     agent any

 
//     stages {
//         // stage('Clone repository') {
//         //     steps {
//         //         git 'https://github.com/Manisha148/Task-K8.git'
//         //     }
//         // }

//         stage('Build image') {
//             steps {
//                 sh 'docker build -t manishaverma/helm .'
//             }
//         }

//         stage('Push image') {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
//                     sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
//                     sh 'docker push manishaverma/helm'
//                 }
//             }
//         }

//        stage('Deploy Helm chart') {
//             steps {
                
//                 sh 'su ubuntu'
//                 sh "helm install ingress-nginx manisha-0.1.0.tgz  --namespace default --set controller.publishService.enabled=true --set controller.service.loadBalancerIP=${env.LB_IP}"
//             }
//         }
    
//        }
//     }
pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        ECR_REGISTRY = '123456789012.dkr.ecr.us-east-1.amazonaws.com' // Replace with your ECR registry URL
        DOCKER_IMAGE = 'my-app' // Replace with the name of your Docker image
        HELM_CHART = 'my-chart' // Replace with the name of your Helm chart
        EKS_CLUSTER = 'my-eks-cluster' // Replace with the name of your EKS cluster
        KUBECONFIG_FILE = 'kubeconfig.yaml' // Replace with the path to your kubeconfig file
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def dockerImage = docker.build("${ECR_REGISTRY}/${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                    docker.withRegistry('', 'ecr:us-east-1') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy Helm Chart') {
            steps {
                sh "aws eks update-kubeconfig --name ${EKS_CLUSTER} --kubeconfig ${KUBECONFIG_FILE}"
                sh "helm upgrade --install my-release ${HELM_CHART} --set image.repository=${ECR_REGISTRY}/${DOCKER_IMAGE},image.tag=${env.BUILD_NUMBER}"
            }
        }
    }

    post {
        always {
            sh "rm ${KUBECONFIG_FILE}"
        }
    }
}

