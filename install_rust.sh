#!/bin/bash

curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

# update to beta
rustup default beta

# install wasm-pack
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh 

cargo install cargo-generate

