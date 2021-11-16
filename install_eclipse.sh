#!/bin/bash
# Installs eclipse. Script should be idempotent.
set -euo pipefail

ECLIPSE_HOME_ROOT=~/.progs/
ECLIPSE_HOME=$ECLIPSE_HOME_ROOT/eclipse
PACKAGE_URL=https://mirrors.jevincanders.net/eclipse/technology/epp/downloads/release/2021-03/R/eclipse-cpp-2021-03-R-linux-gtk-x86_64.tar.gz

echo "Installing Eclipse..."

# don't install if already installed
if [ -d "$ECLIPSE_HOME" ]; then
	echo "Found existing directory at $ECLIPSE_HOME, eclipse already installed!"
    exit 0
fi

echo "fetching package"
mkdir -p tmp
pushd .
cd tmp
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

echo "adding run script to /usr/local/bin/eclipse"

cat > run_eclipse << EOF
#!/bin/bash
set -eu
export GDK_BACKEND=x11
$ECLIPSE_HOME/eclipse
EOF

chmod +x run_eclipse
sudo mv run_eclipse /usr/local/bin/eclipse
popd

echo "Done installing Eclipse!"
