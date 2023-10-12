pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout your Git repository from your in-house code repo (replace with your repo URL)
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], userRemoteConfigs: [[url: 'https://github.com/ratnakottara/p1.git']]])
            }
        }

        stage('Create Dockerfile') {
            steps {
                // Define the Dockerfile content and save it in your repository
                script {
                    def dockerfileContent = """
                    FROM openjdk:11
                    COPY HelloWorld.java /app/
                    WORKDIR /app/
                    RUN javac HelloWorld.java
                    CMD ["java", "HelloWorld"]
                    """
                    writeFile file: 'Dockerfile', text: dockerfileContent
                }
            }
        }

        stage('Build and Test Docker Image') {
          steps {
            script {
              // Define the Dockerfile content and save it in your repository
              def dockerfileContent = """
              FROM openjdk:11
              COPY HelloWorld.java /app/
              WORKDIR /app/
              RUN javac HelloWorld.java
              CMD ["java", "HelloWorld"]
              """
              writeFile file: 'Dockerfile', text: dockerfileContent

              // Build the Docker image using the provided Dockerfile
              def builtImage = docker.build("jenkins-java-img:2", "-f Dockerfile .")

              // Run unit tests inside the Docker container (replace with your test commands)
              builtImage.inside {
                sh 'echo "Running unit tests"'
               }
           }
       }
   }



        stage('Push Docker Image to ECR') {
            steps {
                // Push the Docker image to your AWS ECR repository (replace with your ECR details)
                script {
                    withAWS(credentials: 'Admin-user') {
                        docker.withRegistry('390067525135.dkr.ecr.ap-south-1.amazonaws.com/', 'ecr.ap-south-1:aws-ecr-credentials') {
                            def dockerImage = docker.image("jenkins-java-img:2")
                            dockerImage.push()
                        }
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                // Define deployment steps to an EC2 instance (e.g., SSH, SCP, etc.)
                // Make sure you have SSH keys set up for authentication
                sh 'ssh ec2-user@43.204.25.23 "deploy-command"'
            }
        }

        stage('Configure Security Group') {
            steps {
                // Use AWS CLI or SDK to configure security group for EC2
                sh 'aws ec2 authorize-security-group-ingress --group-id sg-0273520d4b29ccc2f --protocol ssh --port 22 --cidr 172.31.0.0/16'
            }
        }
    }

    post {
        success {
            // Send a success notification or perform any other post-build actions
            emailext body: 'Jenkins job was successful. The Docker image is deployed.', subject: 'Jenkins Job Success', to: 'your-email@example.com'
            echo 'Jenkins job was successful'
        }

        failure {
            // Send a failure notification or perform actions for a failed build
            emailext body: 'Jenkins job failed. Please check the build logs for details.', subject: 'Jenkins Job Failure', to: 'your-email@example.com'
            echo 'Jenkins job failed'
        }
    }
}
