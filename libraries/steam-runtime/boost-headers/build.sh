#!/bin/bash

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# CLONE PHASE
git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f b7b1371
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "boost"
./bootstrap.sh
./b2 headers --prefix="$pfx"
popd


# COPY PHASE
cp -rfv "$pfx"/* "$diststart/common/dist/"
