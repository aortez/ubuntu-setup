#!/bin/bash
set -euo pipefail
echo "Installing and configuring rofi..."

set -x

sudo apt install rofi

mkdir -p ~/.config/rofi/
cp ./rofi_config ~/.config/rofi/config.rasi
