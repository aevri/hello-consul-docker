#! /bin/sh
SERVER_IP=$(getent hosts consul-server | awk '{print $1}')
echo Will connect to ${SERVER_IP}
python -m SimpleHTTPServer 80 &
consul agent -config-dir /config &
until consul join ${SERVER_IP}; do sleep 1; done
consul watch -type key -key hello/leader /bin/contend-leadership.py
echo Waiting ..
wait
