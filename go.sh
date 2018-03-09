#!/bin/bash
set -euo pipefail

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

echo "*********"
echo "update apt-repo so we can install from ppas"
sudo apt-get update

echo " "
echo "***********"
echo "Installing packages..."
# install packages

declare -a PACKAGES=(
"alarm-clock-applet"
"amarok"
"atom"
"build-essential"
"compiz-plugins-extra"
"compizconfig-settings-manager"
"curl"
"clusterssh"
"git"
"gitk"
"gimp"
"gnome-do"
"gparted"
"jq"
"keepass2"
"lxrandr"
"mpg321"
"multitail"
"meld"
"maven"
"mysql-client-core-5.7"
"nmon"
"postgresql-client-9.6"
"postgresql-common"
"redis-tools"
"shutter"
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

echo " "
echo "*********"
echo "Install oracle Java 7 and 8"
#sudo apt-get install -y oracle-java7-installer
sudo apt-get install -y oracle-java8-installer

echo "**********"
echo "Installing Eclipse..."
ECLIPSE_HOME=~/.progs/eclipse
if [ -d "$ECLIPSE_HOME" ]; then
	echo "Found existing directory at $ECLIPSE_HOME, eclipse already installed!"
else
	echo "fetching package and unarchiving"
	mkdir -p tmp
	cd tmp
	wget -N http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/oxygen/1a/eclipse-java-oxygen-1a-linux-gtk-x86_64.tar.gz
	tar zxvf eclipse-java-oxygen-1a-linux-gtk-x86_64.tar.gz
	echo "deploying to target directory"
	mkdir -p ~/.progs/
	mv eclipse ~/.progs/
fi


echo "**********"
echo "Setting some defaults..."
#echo "make alt-right-drag resize windows"
#gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

#echo "move buttons to right"
#gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

#echo "restore normal scrollbars"
#gsettings set com.canonical.desktop.interface scrollbar-mode normal

# set a bunch of nice window movement hotkeys
#gsettings set org.gnome.desktop.wm.keybindings move-to-corner-ne "['<Control><Super>KP_Page_Up']"
#gsettings set org.gnome.desktop.wm.keybindings move-to-corner-nw "['<Control><Super>KP_Home']"
#gsettings set org.gnome.desktop.wm.keybindings move-to-corner-se "['<Control><Super>KP_Page_Down']"
#gsettings set org.gnome.desktop.wm.keybindings move-to-corner-sw "['<Control><Super>KP_End']"
#gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Control><Super>KP_Begin']"
#gsettings set org.gnome.desktop.wm.keybindings move-to-side-n "['<Control><Super>KP_Up','<Control><Super>Up']"
#gsettings set org.gnome.desktop.wm.keybindings move-to-side-s "['<Control><Super>KP_Down','<Control><Super>Down']"
#gsettings set org.gnome.desktop.wm.keybindings move-to-side-w "['<Control><Super>KP_Left','<Control><Super>Left']"
#gsettings set org.gnome.desktop.wm.keybindings move-to-side-e "['<Control><Super>KP_Right','<Control><Super>Right']"

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
