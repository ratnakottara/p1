pipeline {
    agent {
        label 'ubuntu'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from your Git repository
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/ratnakottara/p1.git']]]) 
            }
        }

        stage('Build') {
            steps {
                // Compile the Java application (if needed)
                sh 'javac HelloWorld.java'
            }
        }

        stage('Run') {
            steps {
                // Run the Java application
                sh 'java HelloWorld'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the provided Dockerfile
                sh 'sudo docker build -t my-java-app .'
            }
        }
    }
}
