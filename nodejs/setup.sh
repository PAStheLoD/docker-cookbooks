#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update -qq

apt-get install -y wget ca-certificates apt-transport-https gnupg1 --no-install-recommends

wget -q -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

echo 'deb https://deb.nodesource.com/node_11.x cosmic main' > /etc/apt/sources.list.d/node.list

apt-get update -qq
apt-get install -y nodejs
apt-get remove gnupg1 -y
apt-get autoremove -y
apt-get clean

npm i -g yarn
