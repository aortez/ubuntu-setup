#!/bin/bash
set -euo pipefail

echo "Configuring Atom and installing packages"

echo "Installing custom keymap..."
set -x
set +e
mv ~/.atom/keymap.cson ~/.atom/keymap.bak
set -e
cp atom_keymap.cson ~/.atom/keymap.cson

set +x
echo "Installing packages..."
set -x
# packages to install
apm install linter-eslint
apm install docblockr
apm install ide-typescript
apm install atom-ide-ui
