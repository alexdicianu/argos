FROM ubuntu:14.04
MAINTAINER alex dicianu "alex.dicianu@gmail.com"
RUN apt-get update

RUN apt-get -y install redis-server redis-tools

EXPOSE 6379
ENTRYPOINT [ "/usr/bin/redis-server" ]
CMD []