#! /bin/sh
SERVER_IP=$(getent hosts consul-server | awk '{print $1}')
echo Will connect to ${SERVER_IP}
python -m SimpleHTTPServer 80 &
consul agent -config-dir /config -join ${SERVER_IP} &
wait
