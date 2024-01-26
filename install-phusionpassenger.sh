#!/bin/bash

echo "This script installs Phusion Passenger"
read -p "Do you want to continue? [Y/n] " yn
case $yn in
  [yY] ) ;;
  * ) echo Abort.; exit;;
esac

echo "Please select module for Apache or NGINX:"
echo "Apache [a]"
read -p "NGINX [Enter, default] * " selector
case $selector in
  [a] ) MODULE=Apache;;
  * ) MODULE=NGINX;;
esac
echo "Module is set to $MODULE";

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

echo "Phusion repo key is downloaded and added..."
wget -qO - "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x561f9b9cac40b2f7" | gpg --dearmor -o /etc/apt/trusted.gpg.d/phusion.gpg
echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger jammy main" | sudo tee /etc/apt/sources.list.d/passenger.list

echo "apt update is done (again)...";
apt update

echo "Phusion Passenger (for $MODULE) is installed...";
if [[ "$MODULE" = "Apache" ]]; then
  echo "Apache Apache Apache Apache Apache";
  apt install -y libapache2-mod-passenger
  read -p "Do you want to restart Apache? [Y/n] " yn
  case $yn in
    [yY] )
      echo "Apache is restarted...";
      service apache2 restart;;
  esac
else
  apt install -y libnginx-mod-http-passenger
  read -p "Do you want to restart NGINX? [Y/n] " yn
  case $yn in
    [yY] )
      echo "NGINX is restarted...";
      service nginx restart;;
  esac
fi
