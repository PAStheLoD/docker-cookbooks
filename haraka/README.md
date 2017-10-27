

# how to run it?


Create a run-haraka.sh
Create a docker network `default1`
Run run-haraka.sh!

```
#!/bin/bash

docker rm -f haraka
docker run --name haraka  \
           --restart always \
           --hostname your.fancy.site.tld \
           --network default1 \
           -p 127.0.0.1:25:25 \
           -d \
           -e debug=on -e log_timestamps=on -e acl=disabled -e relay_from_cidr=172.17.0.0/12 \
           haraka

```
