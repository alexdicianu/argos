#!/bin/bash

sed -i "s/REDIS_CACHE_HOST/$REDIS_CACHE_HOST/" /etc/php5/fpm/pool.d/www.conf
sed -i "s/REDIS_CACHE_PORT/$REDIS_CACHE_PORT/" /etc/php5/fpm/pool.d/www.conf

/etc/init.d/php5-fpm start
nginx
