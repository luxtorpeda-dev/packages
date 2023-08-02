#!/bin/bash

# CLONE PHASE
git clone https://github.com/seedhartha/reone.git source
pushd source
git checkout -f 5978e93
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx;$VCPKG_INSTALLED_PATH" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBOOST_ROOT="$VCPKG_INSTALLED_PATH" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_LAUNCHER=OFF \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/bin/reone* "$diststart/32370/dist/"

cp -rfv assets/* "$diststart/32370/dist/"
