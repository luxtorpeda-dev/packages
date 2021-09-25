#!/bin/bash

# CLONE PHASE
git clone https://github.com/akheron/jansson.git jansson
pushd jansson
git checkout -f 684e18c
popd

# BUILD PHASE
pushd jansson
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DJANSSON_BUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd
