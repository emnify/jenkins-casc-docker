# Jenkins Master via Config as Code

This Jenkins Master docker image ([`emnify/jenkins-casc`](https://hub.docker.com/r/emnify/jenkins-casc)) uses
[Jenkins Configuration as Code](https://plugins.jenkins.io/configuration-as-code).

For further information, consult the documentation of the [jenkinsci/jenkins container](https://github.com/jenkinsci/docker/blob/master/README.md)

## Adjusting Configuration

Jenkins global configuration, as well as the seed job, are defined in `config.yml`

## Adding new Jenkins Plugins

To add new plugins just add it to `plugins.txt`

Caution: After the last plugin an empty line is needed, otherwise the last plugin will not be installed!

## Running the Container Locally


1. Environment variable configuration

        cp .env.template jenkins.env
        # adjust jenkins.env according to your needs

1. Run container

    - with docker
      
          docker run --name jenkins --rm -p 8080:8080 -v$(pwd)/config.yml:/var/jenkins_casc.yml  --env-file=jenkins.env emnify/jenkins-casc:latest

    - with docker-compose

          docker-compose up


## Creating a new Container Version

This is hosted in ECR in EMnify shared account (648956897802.dkr.ecr.eu-west-1.amazonaws.com/jenkins-casc).

To trigger a new build, go to [Jenkins pipeline](https://jenkins.oss-eks.dev.emnify.io/job/oss/job/jenkins_build/) and execute the pipeline accordingly with the desired branch.
It will build the container using the commit hash.

## Debugging Automated Plugin Updates

Plugin versions newer than existing ones are supposed to be automatically installed when included in a new container version.
This happens using the `jenkins.sh` and its included [`jenkins-support`](https://github.com/jenkinsci/docker/blob/d1f5c7a70d271dbd74ff25cf765e3e1fa14c1a8b/jenkins-support#L40)
script on container startup.

To read the log file of this process, execute the following code in the _Jenkins Script Console_:

```java
File f = new File(System.getenv('JENKINS_HOME') + '/copy_reference_file.log')
println f.text
```

The startup script won't touch plugins that were manually installed, i.e., miss a `.version_from_image` companion file in `/mnt/ESCFS/application-jenkins-master/plugins/`.
So don't install plugins manually.
