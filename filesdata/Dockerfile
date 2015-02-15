FROM ubuntu:14.04

RUN apt-get update -qq && apt-get upgrade -yqq

VOLUME /var/www/html/drupal7/sites/default/files
VOLUME /var/www/html/drupal8/sites/default/files
VOLUME /var/www/html/wordpress/wp-content/uploads

# Creating a volume container for drupal itself. Not as flexible, but a lot faster.
# VOLUME /var/www/html/drupal8/

CMD /bin/bash