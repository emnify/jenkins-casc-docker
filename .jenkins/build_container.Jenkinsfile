#!/usr/bin/groovy
def LABEL = "build-jenkins-casc-" + UUID.randomUUID().toString().take(8)
pipeline {
  options {
    timestamps()
    ansiColor('xterm')
  }
  agent {
    kubernetes {
      label LABEL
      yamlFile '.jenkins/pods/build_container.yaml'
    }
  }
  stages {
    stage('Container') {
      steps {
        script {
          version=getTag()
        }
        container('kaniko') {
          sh "echo ${version}"
          // sh 'echo \'{ "credsStore": "ecr-login" }\' > /kaniko/.docker/config.json'
          // build_and_push("`pwd`", "Dockerfile", "jenkins-casc", env.GIT_COMMIT.substring(0, 7), "eu-west-1")
        }
      }
    }
  }
}

def getTag() {
    return sh(returnStdout: true, script: "git tag --points-at")
}

def build_and_push(context, dockerfile, repo, tag, region) {
  sh "/kaniko/executor --dockerfile=${dockerfile} --context=${context} --cache=false --destination=648956897802.dkr.ecr.${region}.amazonaws.com/${repo}:${tag}"
}
