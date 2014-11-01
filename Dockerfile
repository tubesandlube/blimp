FROM ubuntu:latest
MAINTAINER George Lewis <schvin@schvin.net>

ENV REFRESHED_AT 2014-11-01

RUN apt-get update -y && apt-get install -y libjson-perl libregexp-common-perl perl 

ADD dockerfile
volume of local to get ~/.docker

