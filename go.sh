#!/bin/bash
set -euo pipefail

declare -a PPAS=(
#"ppa:webupd8team/java"
)
echo " "
echo "***********"
echo "Installing PPAs"
for P in "${PPAS[@]}"
do
  echo "installing PPA: $P"
  set -x
#  sudo add-apt-repository -y $P
  set +x
done

echo "*********"
echo "update apt-repo so we can install from ppas"
sudo apt-get update

echo " "
echo "***********"
echo "Installing packages..."
# install packages

declare -a PACKAGES=(
"alarm-clock-applet"
"build-essential"
"colordiff"
"compiz-plugins-extra"
"compizconfig-settings-manager"
"curl"
"clusterssh"
"git"
"gitk"
"gimp"
"gparted"
"graphviz"
"jq"
"keepassx"
"lxrandr"
"meld"
"maven"
"moreutils"
"mpg321"
"multitail"
"nmon"
"plantuml"
"ubuntu-restricted-extras"
"speedcrunch"
"synaptic"
"vim"
)
PACKAGES_STRING=""
for P in "${PACKAGES[@]}"
do
  PACKAGES_STRING=("$PACKAGES_STRING $P")
done
echo "list of packages: $PACKAGES_STRING"
set -x
sudo apt-get install -y $PACKAGES_STRING
set +x

echo "**********"
echo "Setting some defaults..."
#echo "make alt-right-drag resize windows"
#gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

#echo "move buttons to right"
#gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

#echo "restore normal scrollbars"
#gsettings set com.canonical.desktop.interface scrollbar-mode normal

echo "Replace marco with compiz as the default window manager"
gsettings set org.mate.session.required-components windowmanager compiz

echo "Kill those login sound files"
set +e # do not fail if these files have already been moved
sudo mv /usr/share/sounds/ubuntu/stereo/desktop-login{,-disabled}.ogg
sudo mv /usr/share/sounds/ubuntu/stereo/system-ready{,-disabled}.ogg
set -e

echo "Add upd script"
sudo echo '#!/bin/bash' > upd
sudo echo "sudo apt-get update ; sudo apt-get upgrade" >> upd
sudo mv upd /usr/bin
sudo chmod +x /usr/bin/upd

echo "Install Chrome"
set -x
pushd .
mkdir -p tmp
cd tmp
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
ls
pwd
sudo dpkg -i google-chrome-stable_current_amd64.deb
popd


echo "****************************"
echo "All done!"
