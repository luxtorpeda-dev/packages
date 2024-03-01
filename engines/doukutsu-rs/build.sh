#!/bin/bash

curl https://sh.rustup.rs -sSf | sh -s -- -y

source $HOME/.cargo/env

# CLONE PHASE
git clone https://github.com/doukutsu-rs/doukutsu-rs.git source
pushd source
git checkout -f "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
cargo build --release --bin doukutsu-rs
popd

# COPY PHASE
cp -rfv source/target/release/doukutsu-rs "$diststart/200900/dist/"
