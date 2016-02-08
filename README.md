# stuff I do to setup a new ubuntu system

sudo apt-get install vim

sudo apt-get install git

# install mate-terminal (to restore the lost 'change title' functionality)
# and make it the default
sudo apt-get install gnome-session-flashback
gsettings set org.gnome.desktop.default-applications.terminal exec 'mate-terminal'

# move buttons to right
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

# restore normal scrollbars
gsettings set com.canonical.desktop.interface scrollbar-mode normal
