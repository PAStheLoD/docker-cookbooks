#!/bin/bash

mv /tmp/.cargo /root

cd /root


export DEBIAN_FRONTEND=noninteractive

dpkg --add-architecture armhf

apt-get update -qq

apt-get install -y libssl-dev:armhf g++-arm-linux-gnueabihf curl build-essential pkg-config libsystemd-dev:armhf

curl https://sh.rustup.rs -sSf | bash -s -- -y

cat >>/root/.cargo/config <<EOF
[target.armv7-unknown-linux-gnueabihf]
linker = "arm-linux-gnueabihf-gcc"
EOF


export PATH=$PATH:/root/.cargo/bin
rustup target add armv7-unknown-linux-gnueabihf


echo '#!/bin/bash
PKG_CONFIG_ALLOW_CROSS=1 PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig/ /root/.cargo/bin/cargo build --release $@ --target armv7-unknown-linux-gnueabihf' > /usr/local/bin/supercargo

chmod +x /usr/local/bin/supercargo

rm -rf /var/lib/apt/lists/*  /tmp/* /var/tmp/*

mkdir -p /source

cd /source

