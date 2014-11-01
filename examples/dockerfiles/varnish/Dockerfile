FROM ubuntu:14.04.1
MAINTAINER defermat <defermat@gmail.com>

RUN apt-get -y update && \
    apt-get -y install wget

RUN wget http://repo.varnish-cache.org/debian/GPG-key.txt
RUN apt-key add GPG-key.txt
RUN echo "deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0" | sudo tee -a /etc/apt/sources.list

RUN apt-get -y update && \
    apt-get -y install varnish
