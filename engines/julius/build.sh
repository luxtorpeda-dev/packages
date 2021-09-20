#!/bin/bash

# CLONE PHASE
git clone https://github.com/bvschaik/julius.git source
pushd source
git checkout 68fb288
popd

# BUILD PHASE
pushd "source"
mkdir -p build

cd build
cmake ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/julius" "$diststart/517790/dist/"
