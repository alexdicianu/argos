#!/bin/bash

# Check for Drupal/Wordpress media file permissions.

# Drupal
for site in /var/www/html/*/sites/default
do
	chown -R www-data:www-data $site/files/
	chmod -R 0755 files/
done

# Wordpress
site=''
for site in /var/www/html/*/wp-content
do
	chown -R www-data:www-data $site/upload/
	chmod -R 0755 files/
done

/etc/init.d/php5-fpm start
/usr/sbin/nginx
