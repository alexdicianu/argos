Argos
=================

A light Docker based sandbox image for PHP web development that is based on a Ubuntu 14.04 OS. 

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

## Getting Started
Naboo wedge jawa coruscant dooku naboo mon.

## Installation
Install docker (and boot2docker if you're on OSX or Windows) following the instructions from this page: https://docs.docker.com/#installation-guides
You also need to install docker-compose
```
$ yum -y install git docker python-pip
$ pip install docker-compose==1.1.0-rc2
$ systemctl start docker
$ systemctl enable docker
```
or
```
curl -L https://github.com/docker/fig/releases/download/1.1.0-rc2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose
```

## Components
Naboo wedge jawa coruscant dooku naboo mon.

## Workflow
```
chmod u+x argos
```

Adding a site:
* Drupal: `./argos add site.com /Users/alex/www/site.com drupal`
* Wordpress: `./argos add site.com /Users/alex/www/site.com wordpress`

Removing a site:
```
./argos del site.com
```

See all your sites:
```
./argos site-list
``` 
or 
```
./argos sl
```

Seeing your running containers:
```
docker-compose ps
```

Building your stack:
```
docker-compose build
```

Launching your stack:
```
docker-compose up -d
```

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
<code>docker-compose up -d</code><br />

<strong>Manual run:</strong><br />
<code>docker run -d -t -p 8080:8080 --name nginx --link mysql:db -v /Users/dicix/work/www/proiecte:/var/www/html dicix/nginx</code><br />
<code>docker run -d -t -p 3306:3306 --name mysql --volumes-from mysql_data dicix/mysql</code><br />
<code>docker run -d -t -p 80:80 --name varnish dicix/varnish</code><br />
<code>docker run -d -p 6379:6379 --name redis dicix/redis</code>

