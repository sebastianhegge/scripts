# scripts - a small, growing script collection

## `install-mongodb7.sh`

This script installs MongoDB 7.0 on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois ack-grep net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg key from MongoDB
* adds repo source files to `/etc/apt/sources.list`
* `apt install mongodb-org`

## `install-nodejs.sh`

This script installs NodeJS in selecable version on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* let you select between NodeJS version 18 LTS, 20 LTS or 21
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois ack-grep net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg key from NodeJS
* adds repo source files to `/etc/apt/sources.list`
* `apt install nodejs`
* `corepack enable`

## `install-phusionpassenger.sh`

This script installs the Phusion Passenger on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois ack-grep net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg key from Phusion
* adds repo source file to `/etc/apt/sources.list`
* `apt install libapache2-mod-passenger` or `apt install libnginx-mod-http-passenger`
* optional Webserver restart after installation

## `install-unifi.sh`

This script installs the UniFi Controller from Ubiquiti on Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois ack-grep net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https` (if not installed)
* adds the gpg keys from MongoDB and UniFi
* adds repo source files to `/etc/apt/sources.list`
* installs old OpenSSL 1.1.1f from Ubuntu 20.04 LTS (needed by old MongoDB)
* `apt install mongodb-org`
* `apt install unifi`

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
