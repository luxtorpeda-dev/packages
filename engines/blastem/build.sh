#!/bin/bash

# CLONE PHASE
hg clone https://www.retrodev.com/repos/blastem source
pushd source
hg update 460e14497120
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
cp -rfv tmp/bin/* "$diststart/9050/dist/"
cp -rfv tmp/lib/dhewm3/* "$diststart/9050/dist/"
cp -rfv tmp/bin/* "$diststart/9070/dist/"
cp -rfv tmp/lib/dhewm3/* "$diststart/9070/dist/"
