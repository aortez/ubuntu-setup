#!/bin/bash
# I Ubuntu snap for Firefox has some bugs and other annoying behavior.
# So let's install it from a PPA with apt instead.
# (issues I've had: the snap's download folder is not properly mapped into the normal download folder, thus causing downloads to fail unless the directory is manually specified for each download; the autoupdate feature for the snap can happen without any user input, and will cause new tabs to crash and if you close the browser to restart it, it never properly re-opens the currently open tabs)
set -eoxu pipefail
sudo snap remove firefox
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt update
echo '
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/Mozilla
sudo apt install firefox


