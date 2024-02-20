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
for package in gnupg ca-certificates apt-transport-https; do
  if ! dpkg -l "$package" | grep -q ^ii; then
    apt install -y "$package"
  fi
done

echo "MongoDB 4.4 repo key is downloaded and added..."
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/mongo-4-4.gpg
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

echo "Unifi repo key is downloaded and added..."
wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" | sudo tee /etc/apt/sources.list.d/unifi.list

echo "apt update is done (again)...";
apt update

echo "legacy openssl package is downloaded...";
export SSL_PACKAGE_NAME=libssl1.1_1.1.1f-1ubuntu2.21_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/$SSL_PACKAGE_NAME
echo "legacy openssl package is installed...";
apt install ./$SSL_PACKAGE_NAME
echo "legacy openssl download is removed...";
rm $SSL_PACKAGE_NAME

echo "MongoDB 4.4 is installed...";
apt install -y mongodb-org

echo "Unifi is installed...";
apt install -y unifi
