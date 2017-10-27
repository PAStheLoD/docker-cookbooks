
# TODO: make config/host_list  reset on start from env var
# TODO: make config/plugins    injectable from volume (and or env vars), and check for changes, and if there were changes, run yarn
FROM pasthelod/nodejs:latest

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update -qq && apt-get install -y g++ make && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN yarn global add Haraka


RUN echo "Init Haraka instance files" && haraka -i /usr/local/haraka
# ADD ./config/plugins /usr/local/haraka/config/plugins
RUN cd /usr/local/haraka && yarn

STOPSIGNAL SIGINT
EXPOSE 25
ADD init.sh /init.sh
CMD ["/init.sh"]
