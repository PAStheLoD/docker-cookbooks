
# TODO: make config/host_list  reset on start from env var
# TODO: make config/plugins    injectable from volume (and or env vars), and check for changes, and if there were changes, run yarn
FROM library/node:alpine

#RUN export DEBIAN_FRONTEND=noninteractive && apt-get update -qq && apt-get install -y g++ make && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apk update && \
    apk add yarn python g++ make bash openssl && \
    yarn global add Haraka && \
    echo "Init Haraka instance files" && \
    haraka -i /usr/local/haraka && \
    cd /usr/local/haraka && \
    yarn && \
    apk del python g++ make && \
    find  /var/cache/apk/ -mindepth 1 -delete

STOPSIGNAL SIGINT
EXPOSE 25
EXPOSE 587
ADD init.sh /init.sh
ENTRYPOINT ["/bin/bash", "/init.sh"]
