

```
#!/bin/bash

set -e


# /opt/staging/venv/bin/certbot certonly -d NEVER.FORGET.SYSTEMS --standalone

docker inspect redis -f '{{ .State.Running }}' &>/dev/null && { docker stop redis ;  docker rm -f redis ; }


echo '

###

### this gets overwritten on every Haraka restart

##
# http://download.redis.io/redis-stable/redis.conf

stop-writes-on-bgsave-error yes

# 10MiB
maxmemory 10485760
tcp-backlog 100
dir /data
dbfilename dump.rdb

# for minimal security (because we run --net=host)
bind 127.0.0.1

' > /opt/redis/redis.conf


docker run --name redis \
	   --restart always \
	   --log-driver journald \
	   --network host \
	   --detach \
	   -v /opt/redis:/data \
	   redis:alpine \
	   /data/redis.conf


docker inspect haraka -f '{{ .State.Running }}' &>/dev/null && { docker stop haraka ;  docker rm -f haraka ; }
docker run --name haraka  \
           --restart always \
           --log-driver journald \
           --hostname NEVER.FORGET.SYSTEMS \
           --detach \
           -e debug=on \
           -e redis=on \
           -e log_timestamps=on \
           -e relay_from_cidr=127.0.0.0/24 \
           -e auth_user=test \
           -e auth_password='very3333333secrtPASS' \
           -v /etc/letsencrypt:/etc/letsencrypt:ro \
           -e tls_key=/etc/letsencrypt/live/NEVER.FORGET.SYSTEMS/privkey.pem \
           -e tls_cert=/etc/letsencrypt/live/NEVER.FORGET.SYSTEMS/fullchain.pem \
           -v /opt/haraka/queue:/usr/local/haraka/queue \
           pasthelod/haraka
```


