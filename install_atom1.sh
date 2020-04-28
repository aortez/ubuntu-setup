#!/bin/bash
set -euo pipefail

echo "Installing Atom"
echo "Installing ppa..."
set -x
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
set +x
sudo apt-get update

echo "Installing package..."
sudo apt-get install -y atom
