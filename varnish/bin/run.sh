#!/bin/bash

# sed -i "s/VARNISH_BACKEND_PORT_1/$VARNISH_BACKEND_PORT_1/" /etc/varnish/default_varnish3.vcl
# sed -i "s/VARNISH_BACKEND_PORT_2/$VARNISH_BACKEND_PORT_2/" /etc/varnish/default_varnish3.vcl
# sed -i "s/VARNISH_BACKEND_IP/$VARNISH_BACKEND_IP/" /etc/varnish/default_varnish3.vcl

# If multinode == on - replace the singlenode VCL with the multinode one.
if [ "$VARNISH_MULTINODE" == "on" ]; then
	vcl_file='/etc/varnish/default_varnish3_multinode.vcl'
else
	vcl_file='/etc/varnish/default_varnish3_singlenode.vcl'
fi

# Start varnish and log
varnishd -f $vcl_file -s malloc,100M -a 0.0.0.0:$VARNISH_PORT
varnishlog