#!/bin/bash

echo "This script installs MongoDB 7.0"
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

echo "MongoDB 7.0 repo key is downloaded and added..."
wget -qO - https://pgp.mongodb.com/server-7.0.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-org-7.0.gpg
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

echo "apt update is done (again)...";
apt update

echo "MongoDB 7.0 is installed...";
apt install -y mongodb-org
