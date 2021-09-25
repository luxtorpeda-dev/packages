#!/bin/bash

# CLONE PHASE
git clone https://github.com/harfbuzz/harfbuzz.git harfbuzz
pushd harfbuzz
git checkout -f 505df5a
popd

# BUILD PHASE
pushd harfbuzz
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DHB_HAVE_FREETYPE=ON \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd
