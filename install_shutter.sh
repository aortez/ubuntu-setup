#!/bin/bash
set -euo pipefail

echo "Installing Shutter"
sudo apt-get install shutter

echo "Assinging <shift>Print to `shutter -s`"
dconf load / << EOF
[org/compiz/profiles/mate/plugins/commands]
command20='/usr/bin/mate-system-monitor -p'
command0='mate-screensaver-command --lock'
command1='shutter -s'
run-command0-key='<Super>l'
run-command1-key='<Shift>Print'
EOF

