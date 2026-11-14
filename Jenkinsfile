pipeline {
    agent any

    tools {
        jdk 'JDK17'
        maven 'Maven3'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/nshivak-code/hello.git'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Package') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts 'target/*.jar'
            }
        }

        stage('Deploy Azure') {
            steps {
                bat '''
                az webapp deploy ^
                --resource-group spring-rg ^
                --name springboot-demo ^
                --src-path target\\*.jar ^
                --type jar
                '''
            }
        }
    }
}