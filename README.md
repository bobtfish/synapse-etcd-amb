# Synapse Docker ambassador container - etcd edition

This container is a simple (1 service/port) ambassador container,
using the etcd service watcher.

Example of how you would use this container:

    docker run -d -e SYNAPSE_APP=testservice -e SYNAPSE_PORT=8000 --link etcd:etcd --name testservice-amb bobtfish/synapse-etcd-amb

This makes a container which runs a haproxy on port 8000, and subscribes to the key ``/nerve/services/testservice`` in etcd

Use [my nerve-etcd-amb container](https://github.com/bobtfish/nerve-etcd-amb) to health check and register your service.

And then run your own app, linking it to the service ambassador for the service it depends on:

    docker run -d --link testservice-amb:testservice you/your_app

