pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from your Git repository
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/ratnakottara/p1.git']]])
            }
        }

        stage('Build') {
            steps {
                // Compile the Java application
                sh 'javac HelloWorld.java'
            }
        }

        stage('Run') {
            steps {
                // Run the Java application
                sh 'java HelloWorld'
            }
        }
    }

    post {
        always {
            // Clean up (optional)
            sh 'rm HelloWorld.class'
        }
    }
}
