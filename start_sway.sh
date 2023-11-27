#!/bin/bash
set -eu

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

sway --unsupported-gpu
