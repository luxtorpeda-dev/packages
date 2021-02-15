#!/bin/bash

# CLONE PHASE
git clone https://gitlab.com/Dringgstein/Commander-Genius.git source
pushd source
git checkout 0b56993f
popd

# BUILD PHASE
pushd source
mkdir -p build
cd build
cmake ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/CGeniusExe" "$diststart/9180/dist/"
