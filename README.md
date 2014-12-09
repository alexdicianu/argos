<h4>Connecting to a container and executing commands:</h4>
<code>docker exec -i -t nginx /bin/bash</code>

Local environment

Build:
docker build -t="dicix/nginx" .
docker build -t="dicix/mysql" .

Run:
docker run -d -t -p 80 --name nginx --link mysql:db -v /Users/dicix/work/www/proiecte:/var/www/html dicix/nginx
docker run -d -t -p 3306:3306 --name mysql --volumes-from mysql_data dicix/mysql