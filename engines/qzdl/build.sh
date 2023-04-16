#!/bin/bash

# CLONE PHASE
git clone https://github.com/qbasicer/qzdl.git source
pushd source
git checkout -f 44aaec0
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/zdl "$diststart/common/dist"
cp -rfv "assets"/* "$diststart/common/dist"
