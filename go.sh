#!/bin/bash
set -euf -o pipefail 


declare -a PPAS=(
"ppa:webupd8team/java"
"ppa:webupd8team/atom"
)
echo " "
echo "***********"
echo "Installing PPAs"
for P in "${PPAS[@]}"
do
	echo "installing PPA: $P"
	set -x
	sudo add-apt-repository -y $P
	set +x
done

echo " "
echo "***********"
echo "Installing packages..."
# install packages

declare -a PACKAGES=(
"alarm-clock-applet"
"atom"
"compiz-plugins-extra" 
"compizconfig-settings-manager"
"clusterssh"
"git" 
"gitk"
"keepass2"
"gnome-session-flashback" 
"lxrandr"
"multitail"
"meld"
"mate-terminal"
"nmon"
"shutter"
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

echo " "
echo "*********"
echo "Install oracle Java 7 and 8"
exit 0
#sudo apt-get install -y oracle-java7-installer
#sudo apt-get install -y oracle-java8-installer


echo "*********"
echo "Install atom"
sudo add-apt-repository -y ppa:webupd8team/atom 
sudo apt-get update
sudo apt-get install -y atom

echo "**********"
echo "Setting some defaults..."
# some manual steps for now...
# disable default screenshot hotkeys
# add 2 custom shortcut hotkeys
# for full screen 'shutter -f' default key print scrn
# for selection area 'shutter -s' default key shift-print scrn

# TODO: is there a way to make gnome flashback the default session?

echo "make mate-terminal the default (to restore the lost 'change title' functionality)"
gsettings set org.gnome.desktop.default-applications.terminal exec 'mate-terminal'

echo "make alt-right-drag resize windows"
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

echo "move buttons to right"
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

echo "restore normal scrollbars"
gsettings set com.canonical.desktop.interface scrollbar-mode normal

echo "Kill that login sound file"
sudo mv /usr/share/sounds/ubuntu/stereo/desktop-login{,-disabled}.ogg

