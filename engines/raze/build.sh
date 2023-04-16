#!/bin/bash

# CLONE PHASE
git clone https://github.com/coelckers/Raze.git source
pushd source
git checkout 7cd42e7
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build"/{raze,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv "assets/"* "$diststart/common/dist/"
