#!/bin/bash

sed -i "s/REDIS_CACHE_HOST/$REDIS_CACHE_HOST/" /etc/php5/fpm/pool.d/www.conf
sed -i "s/REDIS_CACHE_PORT/$REDIS_CACHE_PORT/" /etc/php5/fpm/pool.d/www.conf

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
nginx
