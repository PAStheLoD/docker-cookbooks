#!/bin/bash

cd /root

export DEBIAN_FRONTEND=noninteractive

dpkg --add-architecture armhf

apt-get update -qq

apt-get install -y libssl1.0-dev:armhf g++-arm-linux-gnueabihf curl build-essential pkg-config libsystemd-dev:armhf wget

curl https://sh.rustup.rs -sSf | bash -s -- -y

cat >>/root/.cargo/config <<EOF
[target.armv7-unknown-linux-gnueabihf]
linker = "arm-linux-gnueabihf-gcc"
EOF

# install ssl with PIC support for static linking
wget -O /tmp/openssl.tgz https://www.openssl.org/source/openssl-1.0.2l.tar.gz && tar -zxf /tmp/openssl.tgz && cd openssl-1.0.2l && ./config -fPIC --prefix=/usr/local --openssldir=/usr/local/ssl && make && make install && cd ..

export PATH=$PATH:/root/.cargo/bin
rustup target add armv7-unknown-linux-gnueabihf

echo '#!/bin/bash
OPENSSL_LIB_DIR=/usr/local/lib/ OPENSSL_INCLUDE_DIR=/usr/local/include OPENSSL_STATIC=yes PKG_CONFIG_ALLOW_CROSS=1 PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig/ /root/.cargo/bin/cargo build --release $@ --target armv7-unknown-linux-gnueabihf' > /usr/local/bin/supercargo

chmod +x /usr/local/bin/supercargo

rm -rf /var/lib/apt/lists/*  /tmp/* /var/tmp/*

mkdir -p /source

cd /source

