#!/bin/bash

# CLONE PHASE
git clone https://github.com/nukeykt/NBlood.git source
pushd source
git checkout 09143c3
popd

# BUILD PHASE
pushd source
make rr
popd

# COPY PHASE
cp -rfv "source/rednukem" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
