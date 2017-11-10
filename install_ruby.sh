#!/bin/bash
set -euf
set -x

# install dependencies
sudo apt-get -y install git-core curl zlib1g-dev build-essential \
libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties

pushd .
cd
RBENV_HOME="~/.rbenv"
#git clone git://github.com/sstephenson/rbenv.git .rbenv
#echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
#echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#exec $SHELL
 
#git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
#echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
#exec $SHELL

mkdir -p $RBENV_HOME/plugins
git clone https://github.com/rbenv/ruby-build.git $RBENV_HOME/plugins/ruby-build
rbenv install 2.4.1
rbenv global 2.4.1
popd
