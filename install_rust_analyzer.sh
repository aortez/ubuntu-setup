#!/bin/bash
# Installs rust-analyzer, for IDEs (in my case atom).
# Following instructions found here:
# https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
set -euxo pipefail

mkdir -p ~/.local/bin

chmod +x ~/.local/bin/rust-analyzer

curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer

sudo cat <<EOF > /etc/profile.d/local_bin.sh
export PATH=$PATH:~/.local/bin
EOF
