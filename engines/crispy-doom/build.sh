#!/bin/bash

# CLONE PHASE
git clone https://github.com/fabiangreffrath/crispy-doom.git source
pushd source
git checkout 593f5b9
popd

# BUILD PHASE
pushd "source"
./autogen.sh
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

# COPY PHASE
cp -rfv "$pfx/usr/local/bin/"* "$diststart/common/dist/"

cp -rfv assets/* "$diststart/common/dist/"
