pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')   // Jenkins credential ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/KasulaPavanKumar-Cloud/devops-weather-project.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo "Skipping SonarQube analysis for demo..."
                // If you integrate SonarQube later, uncomment below:
                // withSonarQubeEnv('SonarQube') {
                //     sh 'sonar-scanner'
                // }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t kasulapavankumar/weather-app:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh 'echo "Logging into Docker Hub..."'
                sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
                sh 'docker push kasulapavankumar/weather-app:latest'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Deploying to Kubernetes..."
                sh 'kubectl apply -f kubernetes/deployment.yaml || echo "Kubernetes not configured, skipping for now."'
            }
        }
    }

    post {
        success {
            echo '✅ Build and deploy completed successfully!'
        }
        failure {
            echo '❌ Build failed — check Jenkins logs.'
        }
    }
}
