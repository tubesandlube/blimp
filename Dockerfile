FROM ubuntu:latest
MAINTAINER George Lewis <schvin@schvin.net>

# XXX incomplete

ENV REFRESHED_AT 2014-11-01

RUN apt-get update -y && apt-get install -y libjson-perl perl 

ADD dockerfile
volume of local to get ~/.docker

