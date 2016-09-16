#!/bin/bash


echo 'deb http://archive.ubuntu.com/ubuntu/ xenial           main restricted universe multiverse' >  /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu/ xenial-updates   main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu/ xenial-proposed  main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu/ xenial-security  main restricted universe multiverse' >> /etc/apt/sources.list


export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get -y install python3.5 python3.5-dev wget zlib1g-dev libssl-dev libexpat1-dev libffi-dev pkg-config libreadline-dev libsqlite3-dev libbz2-dev libncursesw5-dev

apt-get clean

wget -q -O- https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py | python3.5
rm -f setuptools-*.*.*.tar.gz
rm -f setuptools-*.zip
wget -q -O- https://bootstrap.pypa.io/get-pip.py | python3.5

ln -s /usr/bin/vim.tiny /usr/bin/vim

