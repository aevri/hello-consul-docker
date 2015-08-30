Consul events experiment with Consul+Docker
===========================================

In this directory are artefacts for creating instances of a simple 'hello'
service. The 'hello' service simply serves a static website on port 80.

The 'hello' service instances will respond to the 'die' and 'change' Consul
custom messages.

Here we will use Docker to create and instance of the 'hello' service, then we
will discover and read from it. Next we will change it's output with the
'change' custom event. Finally we will ask it to terminate with the 'die'
custom event.

Worked example
--------------

```
# Make sure a Consul server is running
discovery/ $ ../bin/start_consul_server
discovery/ $ CONSUL_SERVER_IP=$(../bin/get_consul_server_ip)

# Start the 'hello' service
discovery/ $ docker build -t hello docker/
discovery/ $ docker run -d hello

# Discover the 'hello' service via DNS
discovery/ $ HELLO_IP=$(dig @${CONSUL_SERVER_IP} -p 8600 hello.service.consul +short)

# Read from the 'hello' service using curl
discovery/ $ curl ${HELLO_IP}
hello

# Change the output of the 'hello' service with a 'change' event
discovery/ $ docker exec consul-server consul event -name change bye

# Read from the 'hello' service using curl
discovery/ $ curl ${HELLO_IP}
bye

# Terminate the 'hello' service with a 'die' event
discovery/ $ docker exec consul-server consul event -name die
```
