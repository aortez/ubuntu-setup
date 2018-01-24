#!/bin/bash
set -euo pipefail

echo "**********"
echo "Install node and friends"
echo "Install 'n', a node version manager"
N_HOME=~/.progs/n
if [ -d "$N_HOME" ]; then
        echo "Found existing directory at $N_HOME, n already installed!"
else
	mkdir -p ~/.progs
	curl -L https://git.io/n-install | N_PREFIX=$N_HOME bash -s -- -y
fi

echo "Install yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update ; sudo apt-get -y install yarn

