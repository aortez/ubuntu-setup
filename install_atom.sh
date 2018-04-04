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

echo "Installing custom keymap..."
set +e
mv ~/.atom/keymap.cson ~/.atom/keymap.bak
set -e
cp atom_keymap.cson ~/.atom/keymap.cson

echo "atom is now yours"

# packages to install, automate eventually
#apm install linter-eslint
#apm install docblockr
