#!/bin/bash
# installs sway and packages
# requires Ubuntu 19.04
set -eux

# todo add ppa

sudo apt install grim
echo 'export MOZ_ENABLE_WAYLAND=1' | sudo tee /etc/profile.d/firefox
