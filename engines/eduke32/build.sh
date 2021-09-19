#!/bin/bash

# CLONE PHASE
git clone https://voidpoint.io/terminx/eduke32.git source

pushd source
git checkout 71c5ce09
popd

# BUILD PHASE
pushd source
prefix="$pfx" make duke3d
popd

# COPY PHASE
cp -rfv "source/eduke32" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
