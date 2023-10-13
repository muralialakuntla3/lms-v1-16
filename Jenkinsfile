pipeline {
agent any
stages {
    stage('NOTIFICATION-EMAIL') {
        steps {
           sh 'echo pipeline started'
      }
    }
    stage('CODE ANALYSIS-SONARQUBE') {
        steps {
           sh 'echo sonar analysis completed'
      }
    }
    stage('BUILD FOR ARTIFACTS') {
        steps {
           sh 'echo build completed'
      }
    }
    stage('RELEASE ARTIFACTS-NEXUS') {
        steps {
           sh 'echo artifacts pushed to nexus repo'
      }
    }
    stage('BUILD IMAGES-DOCKER') {
        steps {
           sh 'echo docker images build and pushed to docker hub'
      }
    }
    stage('APPROVAL-SLACK/EMAIL') {
        steps {
           sh 'echo requsting approval to deployment'
      }
    }
    stage('DEPLOYMENT-K8S') {
        steps {
           sh 'echo application deployment completed'
      }
    }
    stage('REVERTING DEPLOYMENT') {
        steps {
           sh 'echo deployment revarted'
      }
    }
  }
}
