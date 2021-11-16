#!/bin/bash
set -euo pipefail

echo "Configuring Atom and installing packages"

echo "Installing custom keymap..."
# Get rid of the SHIFT-UP/DOWN to move lines shortcut.
# I am not used to that semantic and it always happens unintentionally.
set -x
set +e
mv ~/.atom/keymap.cson ~/.atom/keymap.bak
set -e
cp atom_keymap.cson ~/.atom/keymap.cson

set +x
echo "Installing custom style..."
set -x
cp atom_styles.less ~/.atom/styles.less

set +x
echo "Installing packages..."
set -x
apm install atom-ide-ui
apm install plantuml-preview; sudo apt install plantuml
