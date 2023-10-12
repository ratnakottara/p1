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
                // Compile the Java application (if needed)
                // Replace 'javac' and 'HelloWorld.java' with your actual build commands
                bat 'javac HelloWorld.java'
            }
        }

        stage('Run') {
            steps {
                // Run the Java application
                // Replace 'java HelloWorld' with your actual run command
                bat 'java HelloWorld'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the provided Dockerfile
                sh 'docker build -t my-java-app .'
            }
        }
    }
}
