# we _need_ this stuff

sudo apt-get install vim git gitk gnome-session-flashback multitail meld

# install mate-terminal (to restore the lost 'change title' functionality)
# and make it the default

sudo apt-get install mate-terminal
gsettings set org.gnome.desktop.default-applications.terminal exec 'mate-terminal'

# make alt-right-drag resize windows
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

# move buttons to right
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

# restore normal scrollbars
gsettings set com.canonical.desktop.interface scrollbar-mode normal
