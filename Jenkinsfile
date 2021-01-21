pipeline {
  agent any

  triggers {
    issueCommentTrigger('.*build this please.*')
  }

  environment {
    SLACK_CHANNEL = '#opensource-cicd'
    DOCKER_REGISTRY = 'docker.io'
  }

  stages {

    stage ('Start') {
      steps {
        cancelPreviousBuilds()
        sendNotifications('STARTED', SLACK_CHANNEL)
      }
    }

    stage ('Building Docker Images') {
      steps {
        container('builder') {
          sh 'make -j images'
        }
      }
    }

    stage ('Unit Testing') {
      steps {
        container('builder') {
          sh 'make test'
        }
      }
    }

    stage ('Pushing Docker Image') {
      when {
        anyOf {
          branch 'master'
        }
      }
      steps {
        container('builder') {
          script {
            docker.withRegistry('', 'dockerhub-credentials') {
              sh 'make push-images'
            }
          }
        }
      }
    }
  }

  post {
    success {
      sendNotifications('SUCCESS', SLACK_CHANNEL)
    }
    failure {
      sendNotifications('FAILED', SLACK_CHANNEL)
    }
  }
}
