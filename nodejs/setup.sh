#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update -qq

apt-get install -y wget ca-certificates apt-transport-https --no-install-recommends

wget -q -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

echo 'deb https://deb.nodesource.com/node_9.x artful main' > /etc/apt/sources.list.d/node.list

apt-get update -qq
apt-get install -y nodejs
apt-get clean

npm i -g yarn
