Leader election experiment with Consul+Docker
=============================================

In this directory are artefacts for creating instances of a simple 'hello'
service. The 'hello' service simply serves a static website on port 80.

The 'hello' service instances will all compete to become the leader of the
'hello' service. Consensus will be achieved by using session locks in the
Consul key/value API.

Here we will use Docker to create an instance of the 'hello' service, then we
will verify that it has become the leader. Next, we will start another 'hello'
service and kill the original one. Finally we will verify that the new 'hello'
service has become leader.

Worked example
--------------

```
# Make sure a Consul server is running
leader/ $ ../bin/start_consul_server
leader/ $ CONSUL_SERVER_IP=$(../bin/get_consul_server_ip)

# Start the 'hello' service three times
leader/ $ docker build -t hello docker/
leader/ $ docker run -d --name hello0 --hostname hello0 hello
leader/ $ docker run -d --name hello1 --hostname hello1 hello
leader/ $ docker run -d --name hello2 --hostname hello2 hello

# View the 'hello/leader' key in the Consul web UI and verify that there is an
# elected leader.
#
# Visit here in a web browser:
#
#   http://localhost:8500/ui/#/dc1/kv/hello/leader/edit
#
# There should be a 'LOCK SESSION' block, with the machine name to the right.
# This will be either 'hello0', 'hello1' or 'hello2'. We will refer to this as
# <<LEADER_NAME>>.

# Kill the current leader
leader/ $ docker kill <<LEADER_NAME>>

# Refresh the 'hello/leader' key in the web browser until the new leader
# appears in the 'LOCK SESSION' block. It will take a few seconds for Consul to
# decide that the old leader is dead, after that it will take ~15 seconds by
# default to release the lock and allow a new leader to take it's place.
#
# Visit here in a web browser:
#
#   http://localhost:8500/ui/#/dc1/kv/hello/leader/edit
#
```
