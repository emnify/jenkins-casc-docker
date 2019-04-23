FROM jenkins/jenkins:2.164.2

# skip the setup wizard
ENV JAVA_ARGS -Djenkins.install.runSetupWizard=false

# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
# ensure that our plugin versions win, not those on disk
RUN for f in /usr/share/jenkins/ref/plugins/*.jpi; do mv $f $f.override ; done
