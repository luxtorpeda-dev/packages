#!/bin/bash

curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env

# CLONE PHASE
git clone https://github.com/ruffle-rs/ruffle.git source
pushd source
git checkout -f 19f9c11
popd

git clone https://github.com/jindrapetrik/jpexs-decompiler.git jpexs-decompiler
pushd jpexs-decompiler
git checkout -f 5bcff4f
popd

# BUILD PHASE
pushd source
cargo build --package ruffle_desktop --release
popd

# COPY PHASE
cp -rfv target/release/ruffle_desktop "$diststart/common/dist/"
cp -rfv assets/*.sh "$diststart/common/dist/"
