#!/bin/bash

# echo $VARNISH_BACKEND_IP
# echo $VARNISH_BACKEND_PORT

# sed -i "s/VARNISH_BACKEND_PORT_1/$VARNISH_BACKEND_PORT_1/" /etc/varnish/default_varnish3.vcl
# sed -i "s/VARNISH_BACKEND_PORT_2/$VARNISH_BACKEND_PORT_2/" /etc/varnish/default_varnish3.vcl
# sed -i "s/VARNISH_BACKEND_IP/$VARNISH_BACKEND_IP/" /etc/varnish/default_varnish3.vcl

# Start varnish and log
varnishd -f /etc/varnish/default_varnish3.vcl -s malloc,100M -a 0.0.0.0:$VARNISH_PORT
varnishlog