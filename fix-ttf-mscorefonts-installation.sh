#!/bin/bash
set -euo pipefail

FILENAME=ttf-mscorefonts-installer_3.7_all.deb
wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/$FILENAME
sudo apt-get purge -y ttf-mscorefonts-installer
sudo apt install ./ttf-mscorefonts-installer_3.7_all.deb
# this might work, need to try sometime.  Should skip step of accepting terms
#echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo apt install ttf-mscorefonts-installer
rm $FILENAME

# force update of font cache - not %100 sure this is the final missing piece, but we will see
sudo fc-cache -f -v
