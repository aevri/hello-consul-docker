#! /bin/sh
JOIN_IP=$(getent hosts consul-server | awk '{print $1}')
echo Will join ${JOIN_IP}
consul agent -config-dir /config &
until consul join ${JOIN_IP}; do sleep 1; done
echo hello | nc -lp 80
consul leave
