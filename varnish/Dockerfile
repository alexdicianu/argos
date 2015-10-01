FROM fedora:21
MAINTAINER Pantheon Systems

RUN yum -y update && yum clean all

# Update the package repository and install applications
RUN yum install -y --setopt=override_install_langs=en --setopt=tsflags=nodocs varnish redhat-rpm-config && rm -rf /var/cache/yum

# Varnish 3 - test
# RUN rpm -Uvh http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/varnish-release/varnish-release-3.0-1.noarch.rpm && yum install -y varnish && rm -rf /var/cache/yum

# Make our custom VCLs available on the container
ADD conf/varnish /etc/default/varnish
ADD conf/default_varnish_multinode.vcl /etc/varnish/default_varnish_multinode.vcl
ADD conf/default_varnish_singlenode.vcl /etc/varnish/default_varnish_singlenode.vcl

# Expose port 80
EXPOSE 80

ADD bin/run.sh /etc/run.sh
RUN chmod a+x /etc/run.sh
ENTRYPOINT /etc/run.sh
