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
     stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifest2"
                build job: 'updatemanifest2', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }

}
