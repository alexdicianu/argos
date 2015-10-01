#!/bin/bash

# Check for Drupal/Wordpress media file permissions.

# Drupal
#for site in /var/www/html/*/sites/default
#do
#	chown -R nginx:nginx $site/files/
#	chmod -R 0755 files/
#done

# Wordpress
#site=''
#for site in /var/www/html/*/wp-content
#do
#	chown -R nginx:nginx $site/upload/
#	chmod -R 0755 files/
#done

/usr/sbin/php-fpm
/usr/sbin/nginx

# /etc/init.d/php5-fpm start
# /usr/sbin/nginx

# systemctl start nginx.service
# systemctl start php-fpm.service