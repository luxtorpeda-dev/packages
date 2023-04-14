#!/bin/bash

# CLONE PHASE
git clone https://github.com/scemino/engge.git source
pushd source
git checkout 5e607bc
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    ..
cmake --build . --config Release
popd

# COPY PHASE
cp -rfv source/build/src/engge "$diststart/569860/dist/"
cp -rfv assets/* "$diststart/569860/dist/"
