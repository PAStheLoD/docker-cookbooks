#!/bin/bash

if [[ $(grep artful /etc/apt/sources.list | wc -l) = 0 ]] ; then
    echo 'deb http://archive.ubuntu.com/ubuntu/  focal           main restricted universe multiverse' >  /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/  focal-backports main restricted universe multiverse' >> /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/  focal-updates   main restricted universe multiverse' >> /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/  focal-proposed  main restricted universe multiverse' >> /etc/apt/sources.list
    echo 'deb http://security.ubuntu.com/ubuntu/ focal-security  main restricted universe multiverse' >> /etc/apt/sources.list
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get -y install python3.9 python3.9-dev python3-distutils wget zlib1g-dev libssl-dev libexpat1-dev libffi-dev pkg-config libreadline-dev libsqlite3-dev libbz2-dev libncursesw5-dev

apt-get clean


wget -q -O- https://bootstrap.pypa.io/get-pip.py | python3.9


ln -s /usr/bin/vim.tiny /usr/bin/vim

