#!/bin/bash

if [[ $(grep zesty /etc/apt/sources.list | wc -l) = 0 ]] ; then
    echo 'deb http://archive.ubuntu.com/ubuntu/ artful           main restricted universe multiverse' >>  /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/ artful-backports main restricted universe multiverse' >> /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/ artful-updates   main restricted universe multiverse' >> /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/ artful-proposed  main restricted universe multiverse' >> /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/ artful-security  main restricted universe multiverse' >> /etc/apt/sources.list
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get -y install python3.6 python3.6-dev wget zlib1g-dev libssl-dev libexpat1-dev libffi-dev pkg-config libreadline-dev libsqlite3-dev libbz2-dev libncursesw5-dev

apt-get clean

wget -q -O- https://bootstrap.pypa.io/get-pip.py | python3.6

ln -s /usr/bin/vim.tiny /usr/bin/vim

