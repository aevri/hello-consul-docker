FROM gliderlabs/consul-agent
RUN apk update && apk add python py-pip
RUN pip install requests
COPY config/ /config
COPY bin/ /bin
RUN echo 'hello' > /index.html
EXPOSE 80
ENTRYPOINT /bin/startup.sh
