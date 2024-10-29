# scripts - a small, growing script collection

## `install-mongodb7.sh`

This script installs MongoDB 7.0 on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg key from MongoDB
* adds repo source files to `/etc/apt/sources.list.d`
* `apt install mongodb-org`

Script is download- and executeable via:
```
wget r.heg.ge/install-mongodb7.sh
chmod +x install-mongodb7.sh
./install-mongodb7.sh
```

## `install-nginx.sh`

This script installs NGINX on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg key from NGINX
* adds repo source files to `/etc/apt/sources.list.d`
* `apt install nginx`

Script is download- and executeable via:
```
wget r.heg.ge/install-nginx.sh
chmod +x install-nginx.sh
./install-nginx.sh
```

## `install-nodejs.sh`

This script installs NodeJS in selecable version on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* let you select between NodeJS version 18 LTS, 20 LTS, 22 (later LTS) or 21
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg key from NodeJS
* adds repo source files to `/etc/apt/sources.list.d`
* `apt install nodejs`
* `corepack enable`

Script is download- and executeable via:
```
wget r.heg.ge/install-nodejs.sh
chmod +x install-nodejs.sh
./install-nodejs.sh
```

## `install-phusionpassenger.sh`

This script installs the Phusion Passenger on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg key from Phusion
* adds repo source file to `/etc/apt/sources.list.d`
* `apt install libapache2-mod-passenger` or `apt install libnginx-mod-http-passenger`
* optional Webserver restart after installation

Script is download- and executeable via:
```
wget r.heg.ge/install-phusionpassenger.sh
chmod +x install-phusionpassenger.sh
./install-phusionpassenger.sh
```

## `install-redis.sh`

This script installs Redis on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg key from Redis
* adds repo source file to `/etc/apt/sources.list.d`
* `apt install redis`

Script is download- and executeable via:
```
wget r.heg.ge/install-redis.sh
chmod +x install-redis.sh
./install-redis.sh
```

## `install-unifi.sh`

This script installs the UniFi Controller from Ubiquiti on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg keys from MongoDB and UniFi
* adds repo source files to `/etc/apt/sources.list.d`
* `apt install mongodb-org`
* `apt install unifi`

Script is download- and executeable via:
```
wget r.heg.ge/install-unifi.sh
chmod +x install-unifi.sh
./install-unifi.sh
```

## `update-minecraft-server.rb`

This script is written in ruby. It looks for the latest Minecraft Server, stops running server, download new one, and start service with new version again.\
The script does the following:
* looks for latest local version
* looks for latest remote version
* if remote is newer, then:
 * stop minecraft service
 * download new version
 * set right file owner and permission on new version
 * replace symlink with new version
 * correct symlink owner
 * start minecraft service

## License
[MIT](LICENSE)
