FROM ubuntu:14.04
MAINTAINER alex dicianu "alex.dicianu@gmail.com"

# Update the package repository and install applications
RUN apt-get update -qq && \
  apt-get upgrade -yqq && \
  apt-get -yqq install varnish && \
  apt-get -yqq clean

# Make our custom VCLs available on the container
ADD varnish /etc/default/varnish
ADD default_varnish3.vcl /etc/varnish/default_varnish3.vcl

# @todo find a better way of handling IPs and ports.
# ENV VARNISH_BACKEND_PORT 8080
# ENV VARNISH_BACKEND_IP 192.168.59.103
# ENV VARNISH_PORT 80

# Expose port 80
EXPOSE 80

ADD bin/run.sh /etc/run.sh
RUN chmod a+x /etc/run.sh
ENTRYPOINT /etc/run.sh