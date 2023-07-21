#!/bin/bash

echo "This script installs the unifi package and all it's requirements on Ubuntu 22.04 LTS"
read -p "Do you want to proceed? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

apt update

read -p "Do you want to do a dist-upgrade first? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  apt dist-upgrade -y
fi

read -p "Do you want to install curl, htop, pwgen, zip, unzip, whois, ack-grep, net-tools and dnsutils? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  apt install -y curl htop pwgen zip unzip whois ack-grep net-tools dnsutils
fi

apt install -y gnupg ca-certificates apt-transport-https

wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/mongo-3-6.gpg
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" | sudo tee /etc/apt/sources.list.d/unifi.list

apt update

export SSL_PACKAGE_NAME=libssl1.1_1.1.1-1ubuntu2.1~18.04.23_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/$SSL_PACKAGE_NAME
apt install ./$SSL_PACKAGE_NAME
rm $SSL_PACKAGE_NAME

apt install -y mongodb-org
apt install -y unifi
