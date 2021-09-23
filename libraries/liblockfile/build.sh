#!/bin/bash

# CLONE PHASE
git clone https://github.com/miquels/liblockfile liblockfile
pushd liblockfile
git checkout -f a3bb92f6
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "liblockfile"
mkdir -p "$pfx/LockFile"
./configure --enable-shared --prefix="$pfx/LockFile"
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/include/"* "/usr/include"
cp -rfv "$pfx/lib64/"* "/usr/lib"
