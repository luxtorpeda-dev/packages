#!/bin/bash

# CLONE PHASE
git clone https://github.com/AliveTeam/alive_reversing.git source
pushd source
git checkout 400a2af
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/Source/AliveExe/AliveExeAE" "$diststart/common/dist/"
cp -rfv "source/build/Source/AliveExe/AliveExeAO" "$diststart/common/dist/"
