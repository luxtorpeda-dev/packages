#!/bin/bash

# CLONE PHASE
git clone https://github.com/fabiangreffrath/crispy-doom.git source
pushd source
git checkout 4d416c7
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
