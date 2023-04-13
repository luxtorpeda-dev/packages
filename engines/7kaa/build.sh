#!/bin/bash

# CLONE PHASE
wget https://github.com/the3dfxdude/7kaa/releases/download/v2.15.5/7kaa-2.15.5.tar.xz
tar xvf 7kaa-2.15.5.tar.xz
mv 7kaa-2.15.5 source

git clone https://github.com/lsalzman/enet.git enet
pushd enet
git checkout 3340d1c
popd

export pfx="$PWD/local"

# BUILD PHASE
pushd enet
autoreconf -vfi
./configure -prefix="$pfx"
make -j "$(nproc)"
make install

autoreconf -vfi
./configure
make -j "$(nproc)"
make install
popd

pushd source
./configure -prefix="$pfx"
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/450140/dist/lib"
cp -rfv "$pfx"/lib/*.so* "$diststart/450140/dist/lib"
cp -rfv "$pfx"/bin/* "$diststart/450140/dist"
cp -rfv "$pfx"/share/7kaa "$diststart/450140/dist/data"
cp -rfv assets/* "$diststart/450140/dist/"
