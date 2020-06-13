#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/coelckers/gzdoom.git source
pushd source
git checkout 5001f36
popd

git clone https://github.com/coelckers/ZMusic.git zmusic
pushd zmusic
git checkout c1bf2f8
popd

# BUILD PHASE
mkdir -p tmp

pushd "zmusic"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=tmp \
    ..
make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DZMUSIC_INCLUDE_DIR=tmp/include \
    -DZMUSIC_LIBRARIES=tmp/lib/libzmusic.so \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
for app_id in $STEAM_APP_ID_LIST ; do
    cp -rfv "source/build"/{gzdoom,soundfonts,*.pk3} "$diststart/$app_id/dist/"
    cp -rfv "source/tmp/lib/libzmusic.so "$diststart/$app_id/dist/"
done
