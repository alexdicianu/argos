#
# Customized VCL file for serving up a Drupal or Wordpress site.
#

acl purge {
    "localhost";
    "127.0.0.1";
}

# Define the list of backends (web servers).

backend node1 {
     .host = "web1";
     .port = "55555";
 }

backend node2 {
      .host = "web2";
      .port = "55555";
 }

# Define the director that determines how to distribute incoming requests.
director default_director round-robin {
  { .backend = node1; }
  { .backend = node2; }
}

sub vcl_deliver {
   if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
        set resp.http.X-Cache-Hits = obj.hits;
    } else {
        set resp.http.X-Cache = "MISS";
    }
}

# Respond to incoming requests.
sub vcl_recv {

  # Set load balancing in place.
  set req.backend = default_director;

  # Add a unique header containing the client address
  remove req.http.X-Forwarded-For;
  set    req.http.X-Forwarded-For = client.ip;

  #[Drupal] Do not cache these paths.
  if (req.url ~ "^/install\.php$" || 
      req.url ~ "^/status\.php$" ||
      req.url ~ "^/update\.php$" ||
      req.url ~ "^.*/ajax/.*$") {
       return (pass);
  }

  # Pipe backup_migrate directly
  if (req.url ~ "^/admin/content/backup_migrate/export" || req.url ~ "^/system/files") {
    return (pipe);
  }

  # Do not cache potentially large files.
  if (req.url ~ "\.(mp3|flv|mov|mp4|mpg|mpeg|avi|dmg)") {
    return (pipe);
  }

  # Allow PURGE from localhost and the box's ip.
  if (req.request == "PURGE") {
      if (!client.ip ~ purge) {
          error 405 "Not allowed.";
       }
       return (lookup);
  }

  # Don't check cache for POSTs and various other HTTP request types
  if (req.request != "GET" && req.request != "HEAD") {
    return(pass);
  }

  # @todo - uncomment this.
  # Do not allow outside access to cron.php or install.php.
  #if (req.url ~ "^/(cron|install)\.php$" && !client.ip ~ internal) {
    # Have Varnish throw the error directly.
    # error 404 "Page not found.";
    # Use a custom error page that you've defined in Drupal at the path "404".
    # set req.url = "/404";
  #}

  # Handle compression correctly. Different browsers send different
  # "Accept-Encoding" headers, even though they mostly all support the same
  # compression mechanisms. By consolidating these compression headers into
  # a consistent format, we can reduce the size of the cache and get more hits.=
  # @see: http:// varnish.projects.linpro.no/wiki/FAQ/Compression
  if (req.http.Accept-Encoding) {
    if (req.url ~ "\.(jpg|png|gif|gz|tgz|bz2|tbz|mp3|ogg)$" || req.url ~ "^/robots\.txt$") {
      # No point in compressing these
      remove req.http.Accept-Encoding;
    }
    if (req.http.Accept-Encoding ~ "gzip") {
      # If the browser supports it, we'll use gzip.
      set req.http.Accept-Encoding = "gzip";
    }
    else if (req.http.Accept-Encoding ~ "deflate") {
      # Next, try deflate if it is supported.
      set req.http.Accept-Encoding = "deflate";
    }
    else {
      # Unknown algorithm. Remove it and send unencoded.
      unset req.http.Accept-Encoding;
    }
  }

  # Always attempt to look-up static files.
  if (req.url ~ "\.(png|gif|jpeg|jpg|ico|swf|css|js)(\?[a-z0-9]+)?$") {
    unset req.http.Cookie;
  }

  # Always have a has_js
  # if (req.http.Cookie) {
  #  set req.http.Cookie = "has_js=1; " + req.http.Cookie;
  # }
  # else {
  #  set req.http.Cookie = "has_js=1";
  # }

  # Remove all cookies that Drupal doesn't need to know about. ANY remaining
  # cookie will cause the request to pass-through to Nginx. For the most part
  # we always set the NO_CACHE cookie after any POST request, disabling the
  # Varnish cache temporarily. The session cookie allows all authenticated users
  # to pass through as long as they're logged in.
  if (req.http.Cookie) {

    # Prefix the existing cookie header with ";" to make all cookies
    # have the form ";$name=$value" for better regexing.
    set req.http.Cookie = ";" + req.http.Cookie;

    # Remove any spaces between semicolons and the beginnings of cookie names.
    set req.http.Cookie = regsuball(req.http.Cookie, "; +", ";");

    # Nuke the annoyingly patterned wordpress_test_cookie
    set req.http.Cookie = regsuball(req.http.Cookie, ";wordpress_test[^;]*", "");


    # Loop through our cache-busting cookie patterns.
    #if (req.http.Cookie ~ ";NO_CACHE=") {
    #    set req.http.X-Bypass-Cache = "1";
    #}

    set req.http.Cookie = regsuball(req.http.Cookie, ";(NO_CACHE=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(S+ESS[a-z0-9]+=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(fbs[a-z0-9_]+=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(SimpleSAML[A-Za-z]+=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(PHPSESSID=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(wordpress[A-Za-z0-9_]*=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(wp-[A-Za-z0-9_]+=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(comment_author_[a-z0-9_]+=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(duo_wordpress_auth_cookie=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(duo_secure_wordpress_auth_cookie=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(bp_completed_create_steps=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(bp_new_group_id=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(wp-resetpass-[A-Za-z0-9_]+=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";((wp_)?woocommerce[A-Za-z0-9_-]+=)", "; \1");


    # Now other cookies we pass to the backend to potentially vary the content.
    # All other cookies will be stripped before hitting the backend.
    set req.http.Cookie = regsuball(req.http.Cookie, ";(has_js=)", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(Drupal[a-zA-Z0-9-_\.]+=)", "; \1");

    # this is a buddypress pattern used in filtering/sorting content, without it these features will not work
    set req.http.Cookie = regsuball(req.http.Cookie, ";(bp-[a-z]+-(scope|filter))", "; \1");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(bp-message-[A-Za-z1-9_-]+)", "; \1");

    # Strip any cookies lacking the telltale space between the semicolon and cookie name.
    set req.http.Cookie = regsuball(req.http.Cookie, ";[^ ][^;]*", "");

    # Replace any leading or trailing spaces and semicolons. This leaves
    # a completely empty cookie header if there are no cookies left.
    set req.http.Cookie = regsuball(req.http.Cookie, "^[; ]+|[; ]+$", "");

    if (req.http.Cookie == "") {
      # If there are no remaining cookies, remove the cookie header. If there
      # aren't any cookie headers, Varnish's default behavior will be to cache
      # the page.
      unset req.http.Cookie;
    }
    # If there still are cookies, the default behavior would be to pass them to the backend.
    # In Pantheon's case this isn't happening.
    # else {
      # If there is any cookies left (a session or NO_CACHE cookie), do not
      # cache the page. Pass it on to the backend directly.
      # return (pass);
    # }
  }
}

# Cache hit: the object was found in cache.
sub vcl_hit {
    if (req.request == "PURGE") {
	      purge;
        error 200 "Purged.";
    }
}

# Cache miss: request is about to be sent to the backend.
sub vcl_miss {
    if (req.request == "PURGE") {
	purge;
        error 404 "Not in cache.";
    }
}

# Routine used to determine the cache key if storing/retrieving a cached page.
sub vcl_hash {
  # Include cookie in cache hash.
  # This check is unnecessary because we already pass on all cookies.
  # if (req.http.Cookie) {
  #   set req.hash += req.http.Cookie;
  # }
}

# Code determining what to do when serving items from the Apache servers.
sub vcl_fetch {
  # Don't allow static files to set cookies.
  if (req.url ~ "(?i)\.(png|gif|jpeg|jpg|ico|swf|css|js|html|htm)(\?[a-z0-9]+)?$") {
    # beresp == Back-end response from the web server.
    unset beresp.http.set-cookie;
  }

  # Allow items to be stale if needed.
  set beresp.grace = 120m;

  # Don't cache something with a zero-length.
  if (req.url ~ "^/sites/default/files/" && beresp.status == 200
      && req.http.Content-Length == "0") {
    set beresp.http.Cache-Control = "no-cache, must-revalidate, post-check=0, pre-check=0";
    return (hit_for_pass);
  }

  # Caching for permanent redirects (301s).
  if (beresp.status == 301) {
    if (beresp.http.Location == req.http.X-Proto + req.http.Host + req.url) {
      # Do not cache requests that 301 to themselves for very long.
      set beresp.http.Cache-Control = "public, max-age=3";
      set beresp.ttl = 3s;
      set beresp.http.X-Pantheon-Debug = "Circular redirect detected.";
    }
    else if (beresp.http.Location ~ "/\?q=") {
      # Do not cache 301s that redirect to ?q=
      # Misfiring clean urls / LIN Media
      # https://pantheon-systems.desk.com/agent/case/15792
      set beresp.http.Cache-Control = "public, max-age=3";
      set beresp.ttl = 3s;
      set beresp.http.X-Pantheon-Debug = "Wow. Such redirect.";
    }
    else if (beresp.http.x-pantheon-endpoint ~ ",") {
      # Comma in your endpoint header? Go jump in a lake. This is a bug.
      set beresp.http.Cache-Control = "no-cache, must-revalidate, post-check=0, pre-check=0";
      set beresp.ttl = 0s;
    }
    else if (!beresp.http.Cache-Control) {
      # Otherwise if no headers, a day is good.
      set beresp.ttl = 1d;
      set beresp.http.Cache-Control = "public, max-age=86400";
    }
  }
}

# In the event of an error, show friendlier messages.
sub vcl_error {
  # Redirect to some other URL in the case of a homepage failure.
  #if (req.url ~ "^/?$") {
  #  set obj.status = 302;
  #  set obj.http.Location = "http://backup.example.com/";
  #}

  # Otherwise redirect to the homepage, which will likely be in the cache.
  set obj.http.Content-Type = "text/html; charset=utf-8";
  synthetic {"
<html>
<head>
  <title>Page Unavailable</title>
  <style>
    body { background: #303030; text-align: center; color: white; }
    #page { border: 1px solid #CCC; width: 500px; margin: 100px auto 0; padding: 30px; background: #323232; }
    a, a:link, a:visited { color: #CCC; }
    .error { color: #222; }
  </style>
</head>
<body onload="setTimeout(function() { window.location = '/' }, 5000)">
  <div id="page">
    <h1 class="title">Page Unavailable</h1>
    <p>The page you requested is temporarily unavailable.</p>
    <p>We're redirecting you to the <a href="/">homepage</a> in 5 seconds.</p>
    <div class="error">(Error "} + obj.status + " " + obj.response + {")</div>
  </div>
</body>
</html>
"};
  return (deliver);
}
