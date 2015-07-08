#!/bin/bash

# If multinode == on - replace the singlenode VCL with the multinode one.
if [ "$VARNISH_MULTINODE" == "on" ]; then
	vcl_file='/etc/varnish/default_varnish3_multinode.vcl'
else
	vcl_file='/etc/varnish/default_varnish3_singlenode.vcl'
fi

# Start varnish and log
varnishd -f $vcl_file -s malloc,100M -a 0.0.0.0:$VARNISH_PORT
varnishlog