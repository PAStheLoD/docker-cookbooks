#!/bin/bash

if [[ $(grep artful /etc/apt/sources.list | wc -l) = 0 ]] ; then
    echo 'deb http://archive.ubuntu.com/ubuntu/  disco           main restricted universe multiverse' >  /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/  disco-backports main restricted universe multiverse' >> /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/  disco-updates   main restricted universe multiverse' >> /etc/apt/sources.list
    echo 'deb http://archive.ubuntu.com/ubuntu/  disco-proposed  main restricted universe multiverse' >> /etc/apt/sources.list
    echo 'deb http://security.ubuntu.com/ubuntu/ disco-security  main restricted universe multiverse' >> /etc/apt/sources.list
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get -y install python3.7 python3.7-dev python3-distutils wget zlib1g-dev libssl-dev libexpat1-dev libffi-dev pkg-config libreadline-dev libsqlite3-dev libbz2-dev libncursesw5-dev

apt-get clean


wget -q -O- https://bootstrap.pypa.io/get-pip.py | python3.7


ln -s /usr/bin/vim.tiny /usr/bin/vim

