# Use an official OpenJDK runtime as the base image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the application JAR file into the container
COPY HelloWorld.jar .

# Specify the command to run your Java application
CMD ["java", "-jar", "HelloWorld.jar"]
