FROM ubuntu:14.04
MAINTAINER alex dicianu "alex.dicianu@gmail.com"
RUN apt-get update --fix-missing

RUN apt-get install -y vim curl wget git build-essential python-software-properties php5 php5-cgi php5-fpm php5-cli php5-mysql php5-curl php5-gd php5-mcrypt php5-intl php5-imap php5-tidy php-pear php5-dev strace

# RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/fpm/php.ini
# RUN sed -i "s/;cgi.fix_pathinfo =*/cgi.fix_pathinfo = 0/" /etc/php5/fpm/php.ini
# RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/cli/php.ini
# RUN sed -i "s/upload_max_filesize =.*/upload_max_filesize = 250M/" /etc/php5/fpm/php.ini
# RUN sed -i "s/post_max_size =.*/post_max_size = 250M/" /etc/php5/fpm/php.ini
# RUN sed -i "s/;listen =*/listen = \/var\/run\/php5-fpm.sock/" /etc/php5/fpm/pool.d/www.conf

# Install redis extension
RUN apt-get install make
RUN pecl install redis

# Enable extensions
RUN echo "extension=redis.so" >> /etc/php5/fpm/php.ini
RUN echo "extension=redis.so" >> /etc/php5/cli/php.ini

# Drush
RUN pear channel-discover pear.drush.org && pear install drush/drush

# PHP (adding Pantheon php.ini and php-fpm.conf to the mix)
ADD php/php.ini /etc/php5/fpm/php.ini
ADD php/php-fpm.conf /etc/php5/fpm/pool.d/www.conf

# nginx
RUN apt-get -y -q install nginx
RUN mkdir -p /var/www/html

ADD nginx/sites/ /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/nginx.conf

# run.sh
ADD bin/run.sh /etc/run.sh
RUN chmod a+x /etc/run.sh

# Set environment variables for Redis, the same way pantheon does.
ENV CACHE_HOST 192.168.59.103
ENV CACHE_PORT 6379

# For some reason, this doesn't get picked up by php-fpm and we need to specify it in php-fpm.conf (http://l33t.peopleperhour.com/2014/03/13/setting-environment-variables-in-php-fpm-when-using-docker-links/)

ENV REDIS_CACHE_HOST 192.168.59.103
ENV REDIS_CACHE_PORT 6379

EXPOSE 8080

ENTRYPOINT /etc/run.sh