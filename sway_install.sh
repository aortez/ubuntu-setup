#!/bin/bash
# installs sway and packages
# requires Ubuntu 19.04
set -eux

# todo add ppa

sudo apt install grim
echo 'export MOZ_ENABLE_WAYLAND=1' | sudo tee /etc/profile.d/firefox

# Something is broken for apparmor and Mako, so let's just disable it for the moment.
# https://github.com/emersion/mako/issues/257
sudo apt install apparmor-utils
sudo aa-disable /etc/apparmor.d/fr.emersion.Mako
