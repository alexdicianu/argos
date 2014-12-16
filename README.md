<h5>Connecting to a container and executing commands:</h5>
<code>docker exec -it nginx /bin/bash</code>

<h5>Local environment</h5>

<strong>Build:</strong><br />
<code>docker build -t="dicix/nginx" .</code><br />
<code>docker build -t="dicix/mysql" .</code>

<strong>Run:</strong><br />
<code>docker run -d -t -p 80 --name nginx --link mysql:db -v /Users/dicix/work/www/proiecte:/var/www/html dicix/nginx</code><br />
<code>docker run -d -t -p 3306:3306 --name mysql --volumes-from mysql_data dicix/mysql</code><br />
<code>docker run -d -t -p 80:80 --name varnish dicix/varnish</code><br />
<code>docker run -d -p 6379:6379 --name redis dicix/redis</code>