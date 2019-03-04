#!/bin/bash
# Let's just install docker from the main repos.
# If that isn't sufficient, previous revisions of this script followed the instructions
# listed below:
# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce

set -euo pipefail

echo "install docker package"
sudo apt-get install -y docker.io

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
