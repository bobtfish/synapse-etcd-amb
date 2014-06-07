#!/bin/bash
if [ "$SYNAPSE_APP" == "" ];then
  echo "SYNAPSE_APP environment variable must be set" >&2
  exit 1
fi
if [ "$SYNAPSE_PORT" == "" ];then
  echo "SYNAPSE_PORT environment variable must be set" >&2
  exit 1
fi
PINGOUT=$(ping -c 1 -i 0 etcd 2>&1);
if [ $? != 0 ];then
  echo "WARNING: Cannot find host named 'etcd', you need to link an etcd container to this container!" >&2
  echo "$PINGOUT" >&2
#  exit 2
fi

sed -i -e"s/%%SYNAPSE_APP%%/${SYNAPSE_APP}/" /synapse.conf.json
sed -i -e"s/%%SYNAPSE_PORT%%/${SYNAPSE_PORT}/" /synapse.conf.json

# Default argument
if [ "$1" == "run" ];then
  exec supervisord -n
fi

# Anything else :)
eval "$*"

