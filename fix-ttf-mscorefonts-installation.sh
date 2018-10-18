#!/bin/bash
set -euo pipefail

FILENAME=ttf-mscorefonts-installer_3.7_all.deb
wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/$FILENAME
sudo apt-get purge -y ttf-mscorefonts-installer
sudo apt install ./ttf-mscorefonts-installer_3.7_all.deb
rm $FILENAME
