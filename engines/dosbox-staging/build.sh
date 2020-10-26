#!/bin/bash

# CLONE PHASE
git clone https://github.com/dosbox-staging/dosbox-staging.git source
pushd source
git checkout -f 8dfca45
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "source"
./autogen.sh
./configure CPPFLAGS="-DNDEBUG" CFLAGS="-O3" CXXFLAGS="-O3" --prefix="$pfx"
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv "$pfx/bin/dosbox" "$diststart/common/dist/"
cp -rfv assets/*.sh "$diststart/common/dist/"
