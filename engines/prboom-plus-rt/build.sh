#!/bin/bash

# CLONE PHASE
git clone https://github.com/sultim-t/prboom-plus-rt.git source
pushd source
git checkout 94ead8d
popd

git clone https://github.com/sultim-t/RayTracedGL1.git RayTracedGL1
pushd RayTracedGL1
git checkout 1e0b789
popd

export currentpwd="$PWD"

# BUILD PHASE
pushd "RayTracedGL1"
mkdir -p Build
cd Build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DRG_WITH_SURFACE_XCB=ON \
    ..
cmake --build .
mkdir RelWithDebInfo
cp libRayTracedGL1.so RelWithDebInfo/
mkdir Debug
cp libRayTracedGL1.so Debug
popd

pushd "source/prboom2"
mkdir -p build
cd build
RTGL1_SDK_PATH="$currentpwd/RayTracedGL1" cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/prboom2/build/prboom-plus" "$diststart/common/dist/"
cp -rfv "source/prboom2/build/prboom-plus.wad" "$diststart/common/dist/"
cp -rfv "source/prboom2/build/prboom-plus-game-server" "$diststart/common/dist/"
cp -rfv RayTracedGL1/libRayTracedGL1.so "$diststart/common/dist/"
cp -rfv "assets/run-prboom-plus-rt.sh" "$diststart/common/dist/"
