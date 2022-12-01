node {
    def app

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
         app = docker.build("uditchauhan07/pipeline")
    }

    stage('Test image') {
  
//   echo "test"
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        // echo "push"
        
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
        }
    }
    stage('Deploy'){
        // echo "deploy"
    }
     stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }
     
 }
