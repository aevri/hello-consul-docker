#! /bin/sh
JOIN_IP=$(getent hosts consul-server | awk '{print $1}')
echo Will join ${JOIN_IP}
consul agent -config-dir /config -join ${JOIN_IP} &
echo hello | nc -lp 80
consul leave
