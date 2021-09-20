#!/bin/bash

# CLONE PHASE
git clone https://voidpoint.io/terminx/eduke32.git source
pushd source
git checkout 71c5ce09
popd

# BUILD PHASE
pushd source
make voidsw
popd

# COPY PHASE
cp -rfv "source/voidsw" "$diststart/common/dist/"

cp -rfv assets/* "$diststart/common/dist/"
