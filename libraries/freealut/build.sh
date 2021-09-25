#!/bin/bash

# CLONE PHASE
git clone https://github.com/vancegroup/freealut.git freealut
pushd freealut
git checkout -f 570dea5
popd

# BUILD PHASE
pushd "freealut"
mkdir build
cd build || exit 1
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/include/"* "/usr/include"
cp -rfv "$pfx/lib/"* "/usr/lib"
