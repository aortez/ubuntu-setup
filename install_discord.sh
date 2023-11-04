#!/bin/bash
set -euo pipefail

# From:
# https://blog.javinator9889.com/discord-ppa-keep-it-up-to-date-on-linux-easily/

echo "**********"
echo "Install discord via ppa..."

echo "Import GPG keys:"
mkdir -p ~/.gnupg
sudo -E gpg --no-default-keyring --keyring=/usr/share/keyrings/javinator9889-ppa-keyring.gpg --keyserver keyserver.ubuntu.com --recv-keys 08633B4AAAEB49FC

echo "Add apt repo:"
sudo tee /etc/apt/sources.list.d/javinator9889-ppa.list <<< "deb [arch=amd64 signed-by=/usr/share/keyrings/javinator9889-ppa-keyring.gpg] https://ppa.javinator9889.com all main"

echo "Install discord:"
sudo apt update && sudo apt install discord
