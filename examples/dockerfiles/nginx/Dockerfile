FROM ubuntu:14.04.1
MAINTAINER defermat <defermat@gmail.com>

RUN apt-get -y update && \
    apt-get -y install g++ \
                       make \
                       wget

RUN wget http://nginx.org/download/nginx-1.4.4.tar.gz
RUN wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.34.tar.gz
RUN wget http://zlib.net/zlib-1.2.8.tar.gz
RUN tar -zxvf nginx-1.4.4.tar.gz
RUN tar -zxvf pcre-8.34.tar.gz
RUN tar -zxvf zlib-1.2.8.tar.gz
WORKDIR nginx-1.4.4
RUN ./configure --with-pcre=../pcre-8.34 --with-zlib=../zlib-1.2.8
RUN make && make install

RUN echo 'daemon off;' >> /usr/local/nginx/conf/nginx.conf
ADD index.html /usr/local/nginx/html/index.html

EXPOSE 80
CMD ["/usr/local/nginx/sbin/nginx"]
