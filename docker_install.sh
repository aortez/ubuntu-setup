#!/bin/bash
# Let's just install docker from the main repos.
# If that isn't sufficient, previous revisions of this script followed the instructions
# listed below:
# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce

set -euo pipefail

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Add current user to docker group to allow sans-sudo usage"
set +e
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
set -e

echo "install docker compose"
#sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

echo "enable command line completion for compose"
#sudo curl -L https://raw.githubusercontent.com/docker/compose/1.19.0/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
