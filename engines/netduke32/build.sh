#!/bin/bash

# CLONE PHASE
git clone https://voidpoint.io/StrikerTheHedgefox/eduke32-csrefactor.git source
pushd source
git checkout c4afe166
popd

# BUILD PHASE
pushd source
make oldmp
popd

# COPY PHASE
cp -rfv "source/netduke32" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
