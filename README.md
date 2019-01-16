# Jenkins Master

Automated build for a Jenkins image including plugins and seed job configured with casc.
This project is inspired by Torben Knerr's [jenkins-pipes-infra](https://github.com/tknerr/jenkins-pipes-infra), which provides a more extensive documentation.

## Adding new jenkins plugins

To add new plugins just add it to `plugins.txt`

Caution: After the last plugin an empty line is needed, otherwise the last plugin will not be installed!

## Running the Container

    #ensure jenkins.env exists
    cp .env.template jenkins.env
    #adjust jenkins.env according to your needs
    #run with docker
    docker run --name jenkins --rm -p 8080:8080 -v$(pwd)/config.yml:/var/jenkins_casc.yml  --env-file=jenkins.env emnify/jenkins:latest
    #run with docker-compose
    docker-compose up

For further information, consult the documentation of the [jenkinsci/jenkins container](https://github.com/jenkinsci/docker/blob/master/README.md)

## Creating a new Container Version

To trigger a new build, create a tag (`<jenkinsVersion>-<iteration>`, e.g. `2.60.1-3` for our 3rd try with Jenkins 2.60.1).
The automated build at Docker Hub will then automatically process this.

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