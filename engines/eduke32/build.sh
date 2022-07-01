#!/bin/bash

# CLONE PHASE
git clone https://voidpoint.io/terminx/eduke32.git source
pushd source
git checkout 54177821
popd

# BUILD PHASE
pushd source
make duke3d
popd

# COPY PHASE
cp -rfv "source/eduke32" "$diststart/common/dist/"

cp -rfv assets/* "$diststart/common/dist/"
