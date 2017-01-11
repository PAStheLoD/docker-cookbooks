export DEBIAN_FRONTEND noninteractive

apt-get upgrade -y
apt-get update
apt-get install -y wget 

wget -qO - http://www.dotdeb.org/dotdeb.gpg | apt-key add -

echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list

apt-get update

# "deb http://ftp.debian.org/debian jessie-backports main"
# "deb http://packages.dotdeb.org jessie-nginx-http2 all"

apt-get install nginx-extras -y

RUN apt-get clean
