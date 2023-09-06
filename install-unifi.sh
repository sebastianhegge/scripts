#!/bin/bash

echo "This script installs the unifi package and all it's requirements on Ubuntu 22.04 LTS"
read -p "Do you want to continue? [Y/n] " yn
case $yn in
  [yY] ) ;;
  * ) echo Abort.; exit;;
esac

echo "apt update is done...";
apt update

read -p "Do you want to do a dist-upgrade first? [Y/n] " yn
case $yn in
  [yY] )
    echo "dist-upgrade is done...";
    apt dist-upgrade -y;;
esac

read -p "Do you want to install curl, htop, pwgen, zip, unzip, whois, ack-grep, net-tools and dnsutils? [Y/n] " yn
case $yn in
  [yY] )
    echo "packages are installed...";
    apt install -y curl htop pwgen zip unzip whois ack-grep net-tools dnsutils;;
esac

echo "gnupg, ca-certificates and apt-transport-https are installed..."
apt install -y gnupg ca-certificates apt-transport-https

echo "MongoDB 3.6 repo key is downloaded and added..."
wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/mongo-3-6.gpg
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

echo "Unifi repo key is downloaded and added..."
wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" | sudo tee /etc/apt/sources.list.d/unifi.list

echo "apt update is done (again)...";
apt update

echo "legacy openssl package is downloaded...";
export SSL_PACKAGE_NAME=libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/$SSL_PACKAGE_NAME
echo "legacy openssl package is installed...";
apt install ./$SSL_PACKAGE_NAME
echo "legacy openssl download is removed...";
rm $SSL_PACKAGE_NAME

echo "MongoDB 3.6 is installed...";
apt install -y mongodb-org

echo "Unifi is installed...";
apt install -y unifi
