FROM gliderlabs/consul-agent
COPY hello-service.json /config/hello-service.json
COPY join.sh /bin/join.sh
EXPOSE 80
ENTRYPOINT /bin/join.sh
