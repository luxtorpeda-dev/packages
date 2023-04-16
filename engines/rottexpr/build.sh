#!/bin/bash

# CLONE PHASE
git clone https://github.com/LTCHIPS/rottexpr.git source
pushd source
git checkout 407e3d8
popd

# BUILD PHASE
pushd "source/src"
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/src/rott "$diststart/238050/dist/"
cp -rfv assets/* "$diststart/238050/dist/"

cp -rfv source/src/rott "$diststart/358410/dist/"
cp -rfv assets/* "$diststart/358410/dist/"
