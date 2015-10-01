FROM fedora:21
MAINTAINER Pantheon Systems

RUN yum -y update && yum clean all
RUN yum -y install nginx && yum clean all

#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN echo "nginx on Fedora" > /usr/share/nginx/html/index.html

#RUN yum -y update && yum clean all
RUN yum -y install nginx php php-cgi php-fpm php-cli php-mysql php-curl php-gd php-mcrypt php-intl php-imap php-tidy php-pear strace php-common && yum clean all

# RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# RUN echo "nginx on Fedora" > /usr/share/nginx/html/index.html

# Install composer.
#RUN curl -sS https://getcomposer.org/installer | php
#RUN mv composer.phar /usr/local/bin/composer
#RUN ln -s /usr/local/bin/composer /usr/bin/composer

# nginx 
#RUN mkdir -p /var/www/html

# PHP (adding Pantheon php.ini and php-fpm.conf to the mix)
COPY php/php.ini /etc/php5/fpm/php.ini
COPY php/php-fpm.conf /etc/php5/fpm/pool.d/www.conf

COPY nginx/sites/ /etc/nginx/conf.d/
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# run.sh
COPY bin/run.sh /etc/run.sh
RUN chmod a+x /etc/run.sh

EXPOSE 55555

ENTRYPOINT /etc/run.sh
