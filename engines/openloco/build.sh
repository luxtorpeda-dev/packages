#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenLoco/OpenLoco.git source
pushd source
git checkout -f fff56d7
git submodule update --init --recursive
popd

git clone https://github.com/jbeder/yaml-cpp.git yaml-cpp
pushd yaml-cpp
git checkout -f c73ee34
popd

# BUILD PHASE
pushd yaml-cpp
mkdir build
cd build
CXXFLAGS="-m32" cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd source
mkdir build
cd build
CXXFLAGS="-m32" cmake \
    -G Ninja \
    -DSTRICT=OFF \
    -DOPENLOCO_BUILD_TESTS=OFF \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
ninja -k0
cp -rfv ../data .
popd

# COPY PHASE
mkdir -p "$diststart/356430/dist/data"

cp -rfv "source/build/OpenLoco" "$diststart/356430/dist/openloco"
cp -rfv "source/build/data/"* "$diststart/356430/dist/data"
cp -rfv "assets/run-openloco.sh" "$diststart/356430/dist"
