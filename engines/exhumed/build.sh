#!/bin/bash

# CLONE PHASE
git clone https://github.com/nukeykt/NBlood.git source
pushd source
git checkout 60f9e42
popd

# BUILD PHASE
pushd source
make exhumed
popd

# COPY PHASE
cp -rfv "source/exhumed" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
