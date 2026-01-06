#!/bin/bash
set -eouxf pipefail

# this guide was pretty useful:
# https://www.techrepublic.com/article/how-to-enable-usb-in-virtualbox/

# add key
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

# add repo
sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

# install USB extension
# download from here:
# https://www.virtualbox.org/wiki/Downloads
# Install via File -> Preferences -> Extensions -> add

# Add user to vboxusers group
sudo usermod -aG vboxusers $USER

# Add user to group for shared filesystem
sudo usermod -aG vboxsf $USER

# install guest additions...
# Here is an example version - modify for whatever the version you are using is
https://download.virtualbox.org/virtualbox/7.0.16/VBoxGuestAdditions_7.0.16.iso
