

# how to run it?


Create a run-haraka.sh
Create a docker network `default1`
Run run-haraka.sh!


```
#!/bin/bash

set -e


# don't forget to set up Let's Encrypt TLS auto renew

docker inspect redis -f '{{ .State.Running }}' &>/dev/null && { docker stop redis ;  docker rm -f redis ; }

docker run --name redis \
           --restart always \
           --log-driver journald \
           --network default1 \
           --detach \
           redis:alpine

docker inspect haraka -f '{{ .State.Running }}' &>/dev/null && { docker stop haraka ;  docker rm -f haraka ; }
docker run --name haraka  \
           --restart always \
           --log-driver journald \
           --hostname DONT.FORGET.THIS.EITHER \
           --network default1 \
           -p 127.0.0.1:25:25 \
           --detach \
           -e debug=on \
           -e redis=on \
           -e log_timestamps=on \
           -e relay_from_cidr=127.0.0.0/24 \
           -e auth_user=test \
           -e auth_password='very3333333secrtPASS' \
           -v /etc/letsencrypt:/etc/letsencrypt:ro \
           -e tls_key=/etc/letsencrypt/live/DONT.FORGET.THIS.EITHER/privkey.pem \
           -e tls_cert=/etc/letsencrypt/live/DONT.FORGET.THIS.EITHER/fullchain.pem \
           -v /opt/haraka/queue:/usr/local/haraka/queue \
           pasthelod/haraka
```


