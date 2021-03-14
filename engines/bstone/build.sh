#!/bin/bash

# CLONE PHASE
git clone https://github.com/bibendovsky/bstone.git source
pushd source
git checkout 2a0db92
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd source
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv "$pfx/bin/"* "$diststart/common/dist/"
