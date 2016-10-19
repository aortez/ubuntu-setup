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

# install oracle java?
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java<X>-installer

# kill that login sound file
sudo mv /usr/share/sounds/ubuntu/stereo/desktop-login{,-disabled}.ogg

# add this to your .bashrc to display git branch and status in the prompt
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
export GIT_PS1_SHOWDIRTYSTATE=1

# add this to .bashrc to add "set title" functionality, e.g.
# $ st yay
# will set your terminal title to "yay"
set_title()
{
ORIG=$PS1
TITLE="\e]2;$*\a"
PS1=${ORIG}${TITLE}
}

