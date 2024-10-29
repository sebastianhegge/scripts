#!/bin/bash

echo "This script installs NodeJS from it's own repositories"
read -p "Do you want to continue? [Y/n] " yn
case $yn in
  [yY] ) ;;
  * ) echo Abort.; exit;;
esac

echo "Please select a NodeJS Major-Version:"
echo "NodeJS 18 LTS [18]"
echo "NodeJS 20 LTS [Enter, default] *"
echo "NodeJS 22 (will later be LTS) [22]"
read -p "NodeJS 21 [21] " selector
case $selector in
  [18] ) NODE_MAJOR=18;;
  [21] ) NODE_MAJOR=21;;
  [22] ) NODE_MAJOR=22;;
  * ) NODE_MAJOR=20;;
esac
echo "Major Version set to $NODE_MAJOR";

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

echo "NodeJS repo key is downloaded and added..."
wget -qO - https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/trusted.gpg.d/nodesource.gpg
echo "deb https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
echo "download and adding done!";

echo "apt update is done (again)...";
apt update
echo "apt update done!";

echo "NodeJS is installed...";
apt install -y nodejs
echo "installation done!";

echo "corepack is enabled, is required, among other things, for yarn ...";
corepack enable
echo "enabling done!";
