#!/bin/bash
if [ "$SYNAPSE_APP" == "" ];then
  echo "SYNAPSE_APP environment variable must be set" >&2
  exit 1
fi
if [ "$SYNAPSE_PORT" == "" ];then
  echo "SYNAPSE_PORT environment variable must be set" >&2
  exit 1
fi
if [ "$ETCD_PORT_4001_TCP_ADDR" == "" ];then
  echo "Cannot find ETCD_PORT_4001_TCP_ADDR variable, you need to link an etcd container to this container!" >&2
  exit 2
fi
if [ "$ETCD_PORT_4001_TCP_PORT" == "" ];then
  ETCD_PORT_4001_TCP_PORT=4001
fi

sed -i -e"s/%%SYNAPSE_APP%%/${SYNAPSE_APP}/" /synapse.conf.json
sed -i -e"s/%%SYNAPSE_PORT%%/${SYNAPSE_PORT}/" /synapse.conf.json
sed -i -e"s/%%ETCD_HOST%%/${ETCD_PORT_4001_TCP_ADDR}/" /synapse.conf.json
sed -i -e"s/%%ETCD_PORT%%/${ETCD_PORT_4001_TCP_PORT}/" /synapse.conf.json

# Default argument
if [ "$1" == "run" ];then
  exec supervisord -n
fi

# Anything else :)
eval "$*"

