FROM fedora:21
MAINTAINER Pantheon Systems

RUN yum -y update && yum clean all
RUN yum -y install redis && yum clean all

EXPOSE 6379

CMD [ "redis-server" ]
