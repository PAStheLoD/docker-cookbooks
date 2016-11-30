FROM ubuntu:yakkety

# yakkety = 16.10
## or import it as: docker import http://cdimage.ubuntu.com/ubuntu-core/daily/current/yakkety-core-amd64.tar.gz


ADD setuptools-pip.sh /setuptools-pip.sh
RUN (bash -x setuptools-pip.sh ; rm setuptools-pip.sh )



