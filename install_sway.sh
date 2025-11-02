#!/bin/bash
# installs sway and packages
set -eux

sudo apt install \
	bemenu \
	grim \
	sway \
	mako-notifier \
	slurp \
	waybar \
	wl-clipboard \
	xclip

echo 'export MOZ_ENABLE_WAYLAND=1' | sudo tee /etc/profile.d/firefox

# Something is broken for apparmor and Mako, so let's just disable it for the moment.
# https://github.com/emersion/mako/issues/257
sudo apt install apparmor-utils
sudo aa-disable /etc/apparmor.d/fr.emersion.Mako

# Copy configuration files.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p ~/.config/sway
mkdir -p ~/.config/waybar
mkdir -p ~/.config/mako
cp "$SCRIPT_DIR/sway_config" ~/.config/sway/config
cp "$SCRIPT_DIR/waybar_config" ~/.config/waybar/config
cp "$SCRIPT_DIR/waybar_style.css" ~/.config/waybar/style.css
cp "$SCRIPT_DIR/mako_config" ~/.config/mako/config
