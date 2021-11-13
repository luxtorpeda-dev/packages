#!/bin/bash

# CLONE PHASE
git clone https://github.com/SuperV1234/SSVOpenHexagon.git source
pushd source
git checkout 5fbfaf2
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/SSVOpenHexagon "$diststart/1358090/dist/"
cp -rfv source/build/OHWorkshopUploader "$diststart/1358090/dist/"
mkdir -p "$diststart/1358090/dist/lib"

cp -rfv assets/* "$diststart/1358090/dist/"
cp -rfv source/build/_deps/sfml-build/lib/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/build/_deps/libsodium-cmake-build/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/build/_deps/zlib-build/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/build/_deps/luajit-build/src/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/build/_deps/imgui-sfml-build/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/_RELEASE/*.so* "$diststart/1358090/dist/lib"
