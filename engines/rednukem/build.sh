#!/bin/bash

# CLONE PHASE
git clone https://github.com/nukeykt/NBlood.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
make rr
popd

# COPY PHASE
cp -rfv "source/rednukem" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
