#!/bin/bash

# CLONE PHASE
git clone https://github.com/Banderi/Ozymandias.git source
pushd source
git checkout 9e28192
popd

# BUILD PHASE
pushd "source"
mkdir -p build

cd build
cmake ..

make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/ozymandias" "$diststart/564530/dist/"
