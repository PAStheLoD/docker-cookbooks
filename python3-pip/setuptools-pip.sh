#!/bin/bash

## needed for pip and other basic packages (like Cython)


echo 'deb http://archive.ubuntu.com/ubuntu/ utopic-backports main restricted' >> /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu/ utopic-security multiverse'       >> /etc/apt/sources.list

sed -ri 's/^deb-src/# deb-src/g' /etc/apt/sources.list

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get -y install python3.4 python3.4-dev wget zlib1g-dev libssl-dev libexpat1-dev libffi-dev pkg-config libreadline-dev libsqlite3-dev libbz2-dev libncursesw5-dev 

apt-get clean

wget -O- https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py | python3.4
rm -f setuptools-*.*.*.tar.gz
rm -f setuptools-*.zip
wget -O- https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python3.4

ln -s /usr/bin/vim.tiny /usr/bin/vim

