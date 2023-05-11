#!/bin/bash

# CLONE PHASE
git clone https://github.com/kraflab/dsda-doom.git source
pushd source
git checkout 4631456
popd

# BUILD PHASE
pushd "source/prboom2"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/prboom2/build/dsda-doom" "$diststart/common/dist/"
cp -rfv "source/prboom2/build/dsda-doom.wad" "$diststart/common/dist/"

cp -rfv "assets/run-dsda-doom.sh" "$diststart/common/dist/"
