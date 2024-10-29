#!/bin/bash

echo "This script installs unifi from it's own repository and all it's requirements from it's repositories"
read -p "Do you want to continue? [Y/n] " yn
case $yn in
  [yY] ) ;;
  * ) echo Abort.; exit;;
esac

echo "apt update is done...";
apt update
echo "apt update done!";

read -p "Do you want to do a dist-upgrade first? [Y/n] " yn
case $yn in
  [yY] )
    echo "dist-upgrade is done...";
    apt dist-upgrade -y;
    echo "dist-upgrade done!";;
esac

read -p "Do you want to install curl, htop, pwgen, zip, unzip, whois, net-tools and dnsutils? [Y/n] " yn
case $yn in
  [yY] )
    echo "packages are installed...";
    for package in curl htop pwgen zip unzip whois net-tools dnsutils; do
      if ! dpkg -l "$package" | grep -q ^ii; then
        apt install -y "$package"
      fi
    done;
    echo "installation done!";;
esac

echo "gnupg, ca-certificates and apt-transport-https are installed..."
for package in gnupg ca-certificates apt-transport-https; do
  if ! dpkg -l "$package" | grep -q ^ii; then
    apt install -y "$package"
  fi
done
echo "installation done!"

echo "MongoDB 7.0 repo key is downloaded and added..."
wget -qO - https://pgp.mongodb.com/server-7.0.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-org-7.0.gpg
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list
echo "download and adding done!";

echo "Unifi repo key is downloaded and added..."
wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" | tee /etc/apt/sources.list.d/unifi.list
echo "download and adding done!";

echo "apt update is done (again)...";
apt update
echo "apt update done!";

echo "MongoDB 7.0 is installed...";
apt install -y mongodb-org
echo "installation done!";

echo "Unifi is installed...";
apt install -y unifi
echo "installation done!";
