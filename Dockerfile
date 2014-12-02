FROM ubuntu:latest

MAINTAINER crazycode

RUN apt-get update
RUN apt-get install python-software-properties software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y

# Accept license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# Install Java
RUN apt-get update
RUN apt-get install oracle-java8-installer -y
RUN apt-get install oracle-java8-set-default -y

RUN useradd -m service
RUN mkdir -p /app/service
RUN mkdir -p /app/logs
RUN mkdir -p /app/data
RUN chown -R service:service /app

# Cleanup test
RUN apt-get -qq clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/oracle-jdk8-installer

USER service
WORKDIR /app/service
VOLUME /app/logs
VOLUME /app/data

ENV HOME /home/service