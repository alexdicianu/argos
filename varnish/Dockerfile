FROM ubuntu:14.04
MAINTAINER alex dicianu "alex.dicianu@gmail.com"

# Update the package repository and install applications
RUN apt-get update -qq && \
  apt-get upgrade -yqq && \
  apt-get -yqq install vim curl wget varnish && \
  apt-get -yqq clean

# Make our custom VCLs available on the container
ADD conf/varnish /etc/default/varnish
ADD conf/default_varnish3_multinode.vcl /etc/varnish/default_varnish3_multinode.vcl
ADD conf/default_varnish3_singlenode.vcl /etc/varnish/default_varnish3_singlenode.vcl

# Expose port 80
EXPOSE 80

ADD bin/run.sh /etc/run.sh
RUN chmod a+x /etc/run.sh
ENTRYPOINT /etc/run.sh