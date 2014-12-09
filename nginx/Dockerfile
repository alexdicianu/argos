FROM ubuntu:14.04
MAINTAINER alex dicianu "alex.dicianu@gmail.com"
RUN apt-get update

RUN apt-get install -y vim curl wget build-essential python-software-properties php5-cli php5-fpm php5-mysql php5-curl php5-gd php5-mcrypt php5-intl php5-imap php5-tidy php-pear strace

RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/fpm/php.ini
RUN sed -i "s/;cgi.fix_pathinfo =*/cgi.fix_pathinfo = 0/" /etc/php5/fpm/php.ini
RUN sed -i "s/;listen =*/listen = \/var\/run\/php5-fpm.sock/" /etc/php5/fpm/pool.d/www.conf
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/cli/php.ini

RUN sed -i "s/upload_max_filesize =.*/upload_max_filesize = 250M/" /etc/php5/fpm/php.ini
RUN sed -i "s/post_max_size =.*/post_max_size = 250M/" /etc/php5/fpm/php.ini

#Drush
RUN pear channel-discover pear.drush.org && pear install drush/drush

# nginx
RUN apt-get -y -q install nginx
RUN mkdir -p /var/www/html
ADD nginx/global.conf /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/nginx.conf

# run.sh
ADD bin/run.sh /etc/run.sh
RUN chmod a+x /etc/run.sh
CMD /etc/run.sh

EXPOSE 80
