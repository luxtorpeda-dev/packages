#!/bin/bash

# CLONE PHASE
git clone https://github.com/Fighter19/CnC_Generals_Zero_Hour.git source
pushd source
git checkout "$COMMIT_HASH"
popd

export VCPKG_INSTALLED_PATH="$PWD/vcpkg_installed/x64-linux-dynamic"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$VCPKG_INSTALLED_PATH/lib/pkgconfig"
export VCPKG_SRC_PATH="$PWD/vcpkg"
export VCPKG_DEFAULT_TRIPLET="x64-linux-dynamic"
export VCPKG_ROOT="$PWD/vcpkg"

# clone repo and setup vcpkg
git clone https://github.com/Microsoft/vcpkg.git vcpkg
./vcpkg/bootstrap-vcpkg.sh

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    --preset deploy \
    -DSAGE_USE_SDL3=ON \
    -DSAGE_USE_GLM=ON \
    -DSAGE_USE_OPENAL=ON \
    ..
cmake --build --preset deploy --target RTS
popd

# COPY PHASE

cp -rfv assets/* "$diststart/common/dist/"
