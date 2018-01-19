#/bin/bash
# My Dell Latitude 7480 does not have physical Home and End keys (they require a Fn modifier),
# this script fixes that by remapping the Alt and Ctrl keys to Home and End.
# I used the following references:
# https://unix.stackexchange.com/questions/65507/use-setxkbmap-to-swap-the-left-shift-and-left-control/65600#65600
# https://unix.stackexchange.com/a/414668

if grep --quiet add_home_and_end_keys$ ~/.bashrc; then
	echo "it is already done!"
else
	echo "mapping right alt and control to Home and End"
	# copy some files into home dir
	cp -r .xkb ~/

	# add a line to .bashrc to trigger the changes
	echo "xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY #add_home_and_end_keys" >> ~/.bashrc
fi
