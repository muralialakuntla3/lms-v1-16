// minikube jenkinsfile 
pipeline {
    agent {
    node {
        label 'docker-slave'
         }
    }
    stages {
        stage('db deployment') {
            steps {
                sh 'cd k8s && kubectl apply -f db-deployment.yml'
            }
        }
         stage('db-cluster-ip-service') {
            steps {
                sh 'cd k8s && kubectl apply -f db-cluster-ip-service.yml'
            }
        }
              stage('database-persistent-volume-claim') {
            steps {
                sh 'cd k8s && kubectl apply -f database-persistent-volume-claim.yml'
            }
        }
              stage('apideployment'){
            steps {
                sh 'cd k8s && kubectl apply -f apideployment.yml'
            }
        }
              stage('api deployment') {
            steps {
                sh 'cd k8s && kubectl apply -f api-deployment.yml'
            }
        }
              stage('api-lb-service') {
            steps {
                sh 'cd k8s && kubectl apply -f api-lb-service.yml'
            }
        }
              stage('web deployment') {
            steps {
                sh 'cd k8s && kubectl apply -f web-deployment.yml'
            }
        }
              stage('web-lb-service') {
            steps {
                sh 'cd k8s && kubectl apply -f web-lb-service.yml'
            }
        }
      
    }
}
