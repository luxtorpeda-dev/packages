#!/bin/bash

# CLONE PHASE
git clone https://github.com/chermenin/REminiscence.git
pushd REminiscence
git checkout -f e846387
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd REminiscence
make
popd

# COPY PHASE
cp -rfv REminiscence/rs "$diststart/961620/dist/rs"
cp -rfv assets/* "$diststart/961620/dist/"
