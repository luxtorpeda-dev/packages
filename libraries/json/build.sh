#!/bin/bash

# CLONE PHASE
git clone https://github.com/nlohmann/json.git json
pushd json
git checkout -f db78ac1
popd

# BUILD PHASE
pushd json
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DJSON_MultipleHeaders=ON \
    ..
make -j "$(nproc)"
make install
popd
