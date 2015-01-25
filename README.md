Docker Drupal image based on Ubuntu 14.04
=================

A light sandbox Docker image for PHP web development that is based on a Fedora 20 OS. 


![Docker logo](http://upload.wikimedia.org/wikipedia/commons/7/79/Docker_(container_engine)_logo.png "Docker logo")


This image with comes built with nginx, PHP-FPM, Drush, MySQL, Redis and Varnish.

## Documentation

Naboo wedge jawa coruscant dooku naboo mon. Darth mandalore lobot c-3p0 hutt naboo droid jango organa. Antilles anakin skywalker mandalorians calamari jar tusken raider k-3po organa. 

#### Table of Contents
* [Getting Started](#)
* [Installation](#)
* [Components](#)
* [Workflow](#)
* [Uninstallation](#)
* [Contribution](#)

## Contributing
We are now looking into the already running container to see if there is a newer image downloaded. If there is a newer we stop the [contribution](#).

## License
We are now looking into mithe already running container to see if there is a newer image downloaded. If there is a newer we stop the old  [MIT](#) license.

## Credits  
Author one (author contact info)

Author two (author contact info) 

<h5>Connecting to a container and executing commands:</h5>
<code>docker exec -it nginx /bin/bash</code>

<h5>Local environment</h5>

<strong>Build:</strong><br />
<code>fig up -d</code><br />

<strong>Manual run:</strong><br />
<code>docker run -d -t -p 8080:8080 --name nginx --link mysql:db -v /Users/dicix/work/www/proiecte:/var/www/html dicix/nginx</code><br />
<code>docker run -d -t -p 3306:3306 --name mysql --volumes-from mysql_data dicix/mysql</code><br />
<code>docker run -d -t -p 80:80 --name varnish dicix/varnish</code><br />
<code>docker run -d -p 6379:6379 --name redis dicix/redis</code>

