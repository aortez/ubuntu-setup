#!/bin/bash
# based on instructions here:
# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce

set -euo pipefail

echo "install packages to allow apt to access an https repo"
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

echo "install gpg key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "let's look for the key, it should probably be there"
sudo apt-key fingerprint 0EBFCD88

echo "set up stable repo"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   artful \# $(lsb_release -cs) \
   stable"
sudo apt-get update

echo "install docker package"
sudo apt-get install -y docker-ce

echo "Add current user to docker group to allow sans-sudo usage"
set +e
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
set -e

echo "install docker compose"
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "enable command line completion for compose"
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.19.0/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
