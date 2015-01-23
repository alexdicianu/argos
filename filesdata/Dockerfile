FROM ubuntu:14.04

RUN apt-get update -qq && apt-get upgrade -yqq

VOLUME /var/www/html/gifter.ro/sites/default/files
VOLUME /var/www/html/drupal8/sites/default/files

VOLUME /var/www/html/wordpress/wp-content/uploads

CMD /bin/bash