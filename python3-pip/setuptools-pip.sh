#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get -y install python3.9 python3.9-dev python3-distutils wget zlib1g-dev libssl-dev libexpat1-dev libffi-dev pkg-config libreadline-dev libsqlite3-dev libbz2-dev libncursesw5-dev

apt-get clean


wget -q -O- https://bootstrap.pypa.io/get-pip.py | python3.9


ln -s /usr/bin/vim.tiny /usr/bin/vim

