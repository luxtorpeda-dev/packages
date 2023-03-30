#!/bin/bash

# CLONE PHASE
git clone https://github.com/freedesktop/uchardet.git

git clone https://github.com/mkxp-z/mkxp-z.git source
pushd source
git checkout -f c419672
popd

# BUILD PHASE
pushd uchardet
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

pushd source
meson build
cd build && ninja
meson configure --bindir=. --prefix=$PWD/local
ninja install
popd

# COPY PHASE
cp -rfv "source/build/local/"* "$diststart/common/dist"
