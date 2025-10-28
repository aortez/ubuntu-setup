#!/bin/bash
set -eu

# Start gnome-keyring-daemon with ssh component.
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

sway --unsupported-gpu
