#!/bin/bash

# CLONE PHASE
git clone https://github.com/dhewm/dhewm3.git source
pushd source
git checkout 3a763fc
popd

# BUILD PHASE
pushd source/neo
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=../../../tmp ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv tmp/bin/* "$diststart/common/dist/"
cp -rfv tmp/lib/dhewm3/* "$diststart/common/dist/"

