Hello World with Docker+Consul
==============================

Simple scripts and Dockerfiles for standing up a local cluster and
experimenting with service discovery, health checks, custom events and leader
election.

These are the experiments, each are in their own subdirectory:

- *discovery*: Create multiple instances of simple 'hello' service which uses
  netcat to output 'hello' on port 80 and then shuts down. Discover running
  instances of the services using Consul DNS and read the output using netcat.

- *events*: The 'hello' service is now a simple HTTP server, it can change it's
  output in response to custom events broadcast with Consul.

Please see the subdirectories for more details.
