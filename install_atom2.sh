#!/bin/bash
set -euo pipefail

echo "Configuring Atom and installing packages"

echo "Installing custom keymap..."
# gets rid of the SHIFT-UP/DOWN to move lines shortcut
# I am not used to that semantic and it always happens unintentionally
set -x
set +e
mv ~/.atom/keymap.cson ~/.atom/keymap.bak
set -e
cp atom_keymap.cson ~/.atom/keymap.cson

set +x
echo "Installing packages..."
set -x
apm install atom-ide-ui
apm install docblockr
apm install ide-typescript
apm install linter-eslint
apm install linter-tslint
apm install plantuml-preview
