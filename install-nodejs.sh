#!/bin/bash

echo "This script installs NodeJS"
read -p "Do you want to continue? [Y/n] " yn
case $yn in
  [yY] ) ;;
  * ) echo Abort.; exit;;
esac

echo "Please select a NodeJS Major-Version:"
echo "NodeJS 16 [1]"
echo "NodeJS 18 [2]"
echo "NodeJS 20 [Enter, default] *"
read -p "NodeJS 21 [4] " selector
case $selector in
  [1] ) NODE_MAJOR=16;;
  [2] ) NODE_MAJOR=18;;
  [4] ) NODE_MAJOR=21;;
  * ) NODE_MAJOR=20;;
esac

echo "Major Version set to $NODE_MAJOR";
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

echo "gnupg and ca-certificates are installed..."
for package in ca-certificates gnupg; do
  if ! dpkg -l "$package" | grep -q ^ii; then
    apt install -y "$package"
  fi
done

echo "NodeJS repo key is downloaded and added..."
wget -qO - https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/trusted.gpg.d/nodesource.gpg
echo "deb https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

echo "apt update is done (again)...";
apt update

echo "Unifi is installed...";
apt install -y nodejs

echo "corepack is enabled, is required, among other things, for yarn ...";
corepack enable
