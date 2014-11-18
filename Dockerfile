FROM docker-dev

#FROM ubuntu:latest
MAINTAINER George Lewis <schvin@schvin.net>

# XXX incomplete

ENV REFRESHED_AT 2014-11-01

RUN apt-get update -y && apt-get install -y libjson-perl perl 

RUN curl -sSL https://get.docker.com/ubuntu/ | sh

#ADD dockerfile
#volume of local to get ~/.docker

RUN mkdir /blimp
RUN cd /blimp && git clone https://github.com/bfirsh/docker.git
RUN cd /blimp/docker && git checkout host-management
#RUN mv /go/src/github.com/docker/docker/ /go/src/github.com/docker/docker.old/
#RUN mv /blimp/docker/ /go/src/github.com/docker/
#RUN hack/make.sh

