#!/bin/bash

# CLONE PHASE
git clone https://github.com/icculus/physfs.git physfs
pushd physfs
git checkout -f f8f8903
popd

# BUILD PHASE
pushd physfs
mkdir build
cd build
cmake ..
make -j "$(nproc)"
make install
popd
