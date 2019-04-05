#!/bin/bash
# Installs eclipse. Script should be idempotent.
set -euo pipefail

ECLIPSE_HOME_ROOT=~/.progs/
ECLIPSE_HOME=$ECLIPSE_HOME_ROOT/eclipse
PACKAGE_URL=http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/2019-03/R/eclipse-cpp-2019-03-R-linux-gtk-x86_64.tar.gz

echo "Installing Eclipse..."

# don't install if already installed
if [ -d "$ECLIPSE_HOME" ]; then
	echo "Found existing directory at $ECLIPSE_HOME, eclipse already installed!"
    exit 0
fi

echo "fetching package"
cd /tmp
if [ -f ./eclipse.tgz ]; then
    echo "package already downloaded"
else
    curl $PACKAGE_URL > eclipse.tgz
fi

echo "unarchiving"
 # remove target unarchive dir before unarchiving
rm -rf ./eclipse
tar zxf eclipse.tgz

echo "deploying to target directory"
mkdir -p $ECLIPSE_HOME_ROOT
mv eclipse $ECLIPSE_HOME_ROOT

echo "Done installing Eclipse!"
