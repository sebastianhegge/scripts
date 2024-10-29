#!/bin/bash

echo "This script installs Redis from it's own repositories"
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

echo "Redis repo key is downloaded and added..."
wget -qO - https://packages.redis.io/gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/redis.gpg
echo "deb [ arch=amd64 ] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list
echo "download and adding done!";

echo "apt update is done (again)...";
apt update
echo "apt update done!";

echo "Redis is installed...";
apt install -y redis
echo "installation done!";
