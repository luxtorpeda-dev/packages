#!/bin/bash

# CLONE PHASE
git clone https://github.com/odamex/odamex.git source
pushd source
git checkout 0880dd0
git submodule update --init --recursive
popd

git clone https://github.com/Doom-Utils/deutex.git
pushd deutex
git checkout ef1c06a
popd

# BUILD PHASE
pushd "deutex"
./bootstrap
./configure
make
make install
popd

pushd source/wad
deutex -rgb 0 255 255 -doom2 bootstrap -build wadinfo.txt ../odamex.wad
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/client/odamex" "$diststart/common/dist/"
chmod +x "$diststart/common/dist/odamex"
cp -rfv "source/odamex.wad" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
