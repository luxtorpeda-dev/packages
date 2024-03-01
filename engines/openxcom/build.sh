#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenXcom/OpenXcom.git source
pushd source
git checkout -f "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv "$pfx/share/" "$diststart/common/dist"
cp -rfv "$pfx/bin/openxcom" "$diststart/common/dist"

cp -rfv ./assets/*.sh "$diststart/common/dist"
