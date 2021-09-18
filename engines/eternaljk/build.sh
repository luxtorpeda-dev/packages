#!/bin/bash

# CLONE PHASE
git clone https://github.com/eternalcodes/EternalJK.git source
pushd source
git checkout a40e793
git am < ../patches/0001-Revert-use-of-7za-from-commit-c2dfd02ebd73b06ba2326c.patch
popd

mkdir -p tmp

# BUILD PHASE
pushd source
mkdir build

cd build
cmake \
    -DCMAKE_INSTALL_PREFIX=../../tmp \
    -DBuildDiscordRichPresence=OFF \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv tmp/JediAcademy/* "$diststart/6020/dist/"
