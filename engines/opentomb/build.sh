#!/bin/bash

# CLONE PHASE
git clone https://github.com/opentomb/OpenTomb.git source
pushd source
git checkout 8e4c249
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/OpenTomb "$diststart/common/dist/"
