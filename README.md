# What is Jenkins?

![Jenkins](https://raw.githubusercontent.com/stephenliang/jenkins-dockerfile/master/logo.png)

Jenkins provides continuous integration services for software development. It is a server-based system running in a servlet container such as Apache Tomcat. It supports SCM tools including AccuRev, CVS, Subversion, Git, Mercurial, Perforce, Clearcase and RTC, and can execute Apache Ant and Apache Maven based projects as well as arbitrary shell scripts and Windows batch commands. 

> [https://en.wikipedia.org/wiki/Jenkins_%28software%29](https://en.wikipedia.org/wiki/Jenkins_%28software%29)

# How to use this image

## Creating a data-only container

To help with the persistence of Jenkins data, you should link a data-only container with this image. You can create a data-only container with this command

	docker create -v /jenkins --name jenkins-data simplyintricate/jenkins

This will create a container with the mount point of `/jenkins` which is used in this Jenkins image.

## Running Jenkins

To start Jenkins, you can run 

	sudo docker run --volumes-from jenkins-data -p 8080:8080 -d docker.stephenliang.pw:5000/private-jenkins

This will start Jenkins on port `8080`. If you wish, you may change the first port operand to `80` so you can access Jenkins without specifying the port.

# Advanced Options

## Running Docker within Dockerized Jenkins

One really neat feature that Docker has is the ability to run Docker within Docker. Since this Jenkins is running within Docker, it makes sense that you should be able to build Docker containers within it. To do so, you will need to add the `--privileged` flag to the run command.

	sudo docker run --privileged --volumes-from jenkins-data -p 8080:8080 -d docker.stephenliang.pw:5000/private-jenkins

The `priviliged` flag enables the docker container to have some elevated permissions available to the host. Be sure you understand the implications of this by visiting the [https://docs.docker.com/reference/run/#runtime-privilege-linux-capabilities-and-lxc-configuration](docker run) documentation page.

In addition, this image doesn't include Docker within it. A sample Dockerfile to include Docker is as follows:

	FROM simplyintricate/jenkins

	# Install Docker
	RUN apt-get update && apt-get -y install curl
	RUN curl -sSL https://get.docker.com/ubuntu/ | sudo sh

	CMD service docker start && java -jar /opt/jenkins.war

# Security

This docker image is re-built weekly to pull in the latest upstream code for security purposes. If for some reason you find that the image is too old (check the build details), please do not use this image.

# Contributing

You can help make this Dockerfile better by contributing at [Github](https://github.com/stephenliang/jenkins-dockerfile)

If you found this Docker image helpful, send a tip via Bitcoin to [14b9y1Qw17coEkJFaAAvuXpKZLadTeBPw7](bitcoin:14b9y1Qw17coEkJFaAAvuXpKZLadTeBPw7)
