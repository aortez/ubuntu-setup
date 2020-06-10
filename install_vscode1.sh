#!/bin/bash
set -euo pipefail

echo "Installing VSCode"
echo "Installing ppa..."
set -x
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
set +x
sudo apt-get update

echo "Installing package..."
sudo apt-get install -y code
