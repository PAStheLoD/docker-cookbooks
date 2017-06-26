#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update -qq

apt-get install -y wget ca-certificates apt-transport-https --no-install-recommends

wget -q -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

echo 'deb https://deb.nodesource.com/node_8.x zesty main' > /etc/apt/sources.list.d/node.list

apt update -qq
apt install -y nodejs
apt-get clean
