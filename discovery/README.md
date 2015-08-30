Service discovery experiment with Consul+Docker
===============================================

In this directory are artefacts for creating instances of a simple 'hello'
service. The 'hello' service simply listens on port 80, sends 'hello' and then
terminates.

The 'hello' service instances are advertised using Consul; this means that they
can be discovered using DNS.

Here we will use Docker to create multiple instances of the 'hello' service.
Then we will use the `dig` utility to discover the services via Consul DNS.
Finally we will use `nc` to connect to the hello service and read what it has
to say.

Worked example
--------------

```
# Make sure a Consul server is running
discovery/ $ ../bin/start_consul_server
discovery/ $ CONSUL_SERVER_IP=$(../bin/get_consul_server_ip)

# See that the Consul web UI is up and running on your local machine, visit
# http://localhost:8500 in your web browser

# Start the 'hello' service
discovery/ $ docker build -t hello docker/
discovery/ $ docker run -d hello

# See that the 'hello' service has been added to Consul, visit the web UI again
# http://localhost:8500

# Discover the 'hello' service via DNS
discovery/ $ HELLO_IP=$(dig @${CONSUL_SERVER_IP} -p 8600 hello.service.consul +short)

# Read from the 'hello' service using nc
discovery/ $ nc ${HELLO_IP} 80
hello

# See that the 'hello' service has been removed from Consul, visit the web UI
# http://localhost:8500
```
