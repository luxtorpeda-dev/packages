#!/bin/bash

# CLONE PHASE
git clone https://github.com/clipmove/NotBlood.git source
pushd source
git checkout 7813e43
popd

# BUILD PHASE
pushd source
make blood
popd

# COPY PHASE
cp -rfv "source/notblood" "$diststart/common/dist/"
cp -rfv "source/notblood.pk3" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
