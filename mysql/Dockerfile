FROM ubuntu:14.04

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get -y install mysql-client mysql-server

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

ADD bin/run.sh /etc/run.sh
RUN chmod a+x /etc/run.sh

EXPOSE 3306

ENTRYPOINT /etc/run.sh