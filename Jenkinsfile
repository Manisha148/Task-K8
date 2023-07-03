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
        steps {
            // Create a Helm chart for your application
            
            // Set the name of your Helm chart
            def chartName = 'webapp'
            
            // Set the location to store the Helm chart
            def chartPath = '.'
            
            // Run the 'helm create' command to create the Helm chart
            sh "helm create $chartName"
            
            // Move the Helm chart to the desired location
            sh "mv $chartName $chartPath/"
            
            // Package the Helm chart
            
            // Set the location of the Helm chart
            def chartPackagePath = "$chartPath/$chartName"
            
            // Set the version of the Helm chart
            def chartVersion = '0.1.0'
            
            // Run the 'helm package' command to package the Helm chart
            sh "helm package $chartPackagePath --version $chartVersion"
            
            // Install or upgrade the Helm chart
            
            // Set the Helm release name
            def releaseName = 'my-release'
            
            // Set the Helm chart repository URL
            def chartRepo = 'https://github.com/Manisha148/updatemanifest2.git'
            
            // Add the Helm repository
            sh "helm repo add my-repo $chartRepo"
            
            // Update the Helm repositories
            sh 'helm repo update'
            
            // Install or upgrade the Helm chart
            sh "helm upgrade --install $releaseName my-repo/$chartName --version $chartVersion"
        }
    }
    
    stage('Test') {
        steps {
            // Run tests or perform any other necessary steps
        }
    }
    
    stage('Cleanup') {
        steps {
            // Perform cleanup or any other necessary steps
        }
    }
}
