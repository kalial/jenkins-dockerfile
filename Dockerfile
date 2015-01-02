FROM ubuntu

RUN apt-get update -y && apt-get install -y openjdk-7-jre-headless && apt-get clean
ADD http://mirrors.jenkins-ci.org/war/1.595/jenkins.war /opt/jenkins.war

RUN chmod 644 /opt/jenkins.war

# Persistent jenkins data should be volume
ENV JENKINS_HOME /jenkins
VOLUME ["/jenkins"]

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]

EXPOSE 8080
