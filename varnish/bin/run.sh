#!/bin/bash

# Start varnish and log
varnishd -f /etc/varnish/default_varnish3.vcl -s malloc,100M -a 0.0.0.0:80
varnishlog