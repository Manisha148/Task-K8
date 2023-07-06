pipeline {
    agent any

 
    stages {
        // stage('Clone repository') {
        //     steps {
        //         git 'https://github.com/Manisha148/Task-K8.git'
        //     }
        // }

        stage('Build image') {
            steps {
                sh 'docker build -t manishaverma/helm .'
            }
        }

        stage('Push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    sh 'docker push manishaverma/helm'
                }
            }
        }

        stage ('Helm Deploy') {
          steps {
            script {
                sh "helm upgrade first --install mychart --namespace default 
                }
            }
        }
    
       }
    }

// pipeline {
//     agent any

//     stages {
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

//         stage('Deploy Helm Chart') {
//             steps {
//                 sh "aws eks update-kubeconfig --name $Task --kubeconfig $."
//                 sh "helm upgrade --install my-release $helm --set image.repository=manishaverma/helm,image.tag=${env.BUILD_NUMBER}"
//             }
//         }
//     }

//     post {
//         always {
//             sh "rm ${KUBECONFIG_FILE}"
//         }
//     }
// }

 

