#!/bin/bash

# If multinode == on - replace the singlenode VCL with the multinode one.
if [ "$VARNISH_MULTINODE" == "on" ]; then
	vcl_file='/etc/varnish/default_varnish_multinode.vcl'
else
	vcl_file='/etc/varnish/default_varnish_singlenode.vcl'
fi

# Start varnish and log
#varnishd -f $vcl_file -s malloc,100M -a 0.0.0.0:$VARNISH_PORT
exec varnishd -a :$VARNISH_PORT -f $vcl_file -s malloc,100M -S /etc/varnish/secret -F $VARNISH_OPTS
#varnishlog