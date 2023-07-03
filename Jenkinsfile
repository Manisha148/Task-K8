node {
    def app

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        app = docker.build("manishaverma/javaimg")
    }

    stage('Test image') {
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
        }
    }

    stage('Deploy Helm chart') {
        environment {
            HELM_REPO_URL = 'https://github.com/Manisha148/updatemanifest2.git'
            HELM_CHART_NAME = ' webapp-0.1.0'
            HELM_RELEASE_NAME = 'manisha'
            HELM_NAMESPACE = 'default'
        }
        steps {
            sh "helm repo add myrepo $HELM_REPO_URL"
            sh "helm dependency update $HELM_CHART_NAME"
            sh "helm upgrade --install $HELM_RELEASE_NAME $HELM_CHART_NAME --namespace $HELM_NAMESPACE"
        }
    }
}
