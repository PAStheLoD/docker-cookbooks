FROM ubuntu:utopic

## best to import it as: docker import http://cdimage.ubuntu.com/ubuntu-core/daily/current/trusty-core-amd64.tar.gz gijzelaerr/trusty



ADD setuptools-pip.sh /setuptools-pip.sh
RUN (bash -x setuptools-pip.sh ; rm setuptools-pip.sh )



