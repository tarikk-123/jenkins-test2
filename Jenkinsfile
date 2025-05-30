pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        IMAGE_NAME = 'tarik1661/flask-app'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm

                // Dizini ve içeriklerini göster
                sh '''
                    echo "Bulunduğum dizin:"
                    pwd
                    echo "Dizin içeriği:"
                    ls -la
                '''
            }
        }

        stage('flask.app commit count and environment info') {
            steps {
                script {
                    // Hostname, dizin bilgisi ve ls çıktısı
                    sh """
                        echo "Hostname: \$(hostname)"
                        echo "Current directory: \$(pwd)"
                        echo "Directory contents:"
                        ls -la
                    """

                    // App.java dosyasına yapılmış commit sayısını al
                    def AppflaskCommitCount = sh(
                        script: "git rev-list --count HEAD -- App.java",
                        returnStdout: true
                    ).trim()
                    env.VERSION = "1.0.${AppflaskCommitCount}"
                    echo "Docker image version: ${env.VERSION}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${VERSION} ."
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    sh """
                        echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${IMAGE_NAME}:${VERSION}"
                }
            }
        }
        }
        
    }
