#!/bin/bash
set -euf
set -x

echo "installing rvm..."
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install -y rvm
pushd .
cd /usr/local/bin
sudo ln -s /usr/share/rvm/bin/rvm
popd

set +x
echo "logout, login, then run:"
echo "rvm install ruby"
