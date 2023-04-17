#!/bin/bash

# CLONE PHASE
git clone https://github.com/MadDeCoDeR/Classic-RBDOOM-3-BFG.git source
pushd source
git checkout 36d7185
git submodule update --init --recursive
popd

pushd "source/neo"
mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DSDL2=ON \
    -DCMAKE_PREFIX_PATH="$pfx" \
    --preset=linux-retail \
    ..

cd ../../buildRetail
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/buildRetail/DoomBFA" "$diststart/208200/dist/DoomBFA"
cp -rfv ./assets/* "$diststart/208200/dist/"
cp -rfv ./source/base "$diststart/208200/dist/updatedbase"
