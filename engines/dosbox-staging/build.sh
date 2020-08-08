#!/bin/bash

# CLONE PHASE
git clone https://github.com/dosbox-staging/dosbox-staging.git source
pushd source
git checkout -f 70999dc
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "source"
./autogen.sh
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv "$pfx/bin/dosbox" "$diststart/common/dist/"
cp -rfv assets/*.sh "$diststart/common/dist/"
