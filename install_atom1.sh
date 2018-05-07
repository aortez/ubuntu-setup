#!/bin/bash
set -euo pipefail

echo "Installing Atom"
echo "Installing ppa..."
set -x
sudo add-apt-repository -y "ppa:webupd8team/atom"
set +x
sudo apt-get update

echo "Installing package..."
sudo apt-get install -y atom
