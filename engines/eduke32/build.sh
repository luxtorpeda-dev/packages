#!/bin/bash

# CLONE PHASE
git clone https://voidpoint.io/terminx/eduke32.git source
pushd source
git checkout b7d4ae3a561e0e6f26d999ce5dde7328c68725c0
popd

# BUILD PHASE
pushd source
make duke3d
popd

# COPY PHASE
cp -rfv "source/eduke32" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
