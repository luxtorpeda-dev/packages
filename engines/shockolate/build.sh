#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interrupt/systemshock.git source
pushd source
git checkout 7da4d1b
popd

# BUILD PHASE

pushd source
mkdir build
cd build
cmake ..
make -j "$(nproc)" systemshock
popd

# COPY PHASE
cp -rfv build/systemshock "$diststart/common/dist/"
