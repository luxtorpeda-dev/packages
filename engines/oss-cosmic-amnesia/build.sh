#!/bin/bash

# CLONE PHASE
git clone https://github.com/OSS-Cosmic/AmnesiaTheDarkDescent.git source
pushd source
git checkout -f 6b387d7

git clone https://github.com/OSS-Cosmic/The-Forge.git external/The-Forge
git checkout -f 80ddbfe
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
DESTDIR="$tmp" make install
popd

# COPY PHASE
cp -rfv "source/build/"* "$diststart/57300/dist"
cp -rfv "assets/"* "$diststart/57300/dist"
