# scripts - a small, growing script collection

## `install-unifi.sh`

This script installs the UniFi Controller from Ubiquiti on an Ubuntu 22.04 LTS.\
It may be adjustable for other Ubuntu / Debian distributions.\
The script does the following:
* `apt update`
* `apt dist-update` (optional)
* `apt install curl htop pwgen zip unzip whois ack-grep net-tools dnsutils` (optional)
* `apt install gnupg ca-certificates apt-transport-https`
* adds the gpg keys from MongoDB and UniFi
* installs old OpenSSL 1.1.1f from Ubuntu 20.04 LTS (needed by MongoDB)
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
