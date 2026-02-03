#!/bin/bash
set -euo pipefail

# Start gnome-keyring-daemon for secrets, certificates, and SSH.
eval "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"

# Prefer the GCR ssh agent socket when available (common on newer Ubuntu/GNOME).
if [ -n "${XDG_RUNTIME_DIR:-}" ]; then
  if systemctl --user -q is-enabled gcr-ssh-agent.socket >/dev/null 2>&1 || \
     [ -d "$XDG_RUNTIME_DIR/gcr" ]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
  elif [ -d "$XDG_RUNTIME_DIR/keyring" ]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"
  fi
fi

# Launch sway after keyring so all child processes inherit SSH_AUTH_SOCK.
exec sway --unsupported-gpu
