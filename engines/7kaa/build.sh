#!/bin/bash

# CLONE PHASE
git clone https://git.code.sf.net/p/skfans/7kaa source
pushd source
git checkout "$COMMIT_HASH"
popd

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
autoreconf -vfi
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
