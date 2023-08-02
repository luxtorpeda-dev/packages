#!/bin/bash

# CLONE PHASE
git clone https://github.com/seedhartha/reone.git source
pushd source
git checkout -f b2f0484
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/bin/reone* "$diststart/32370/dist/"

cp -rfv assets/* "$diststart/32370/dist/"
