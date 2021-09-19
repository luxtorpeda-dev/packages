#!/bin/bash

# CLONE PHASE
git clone https://github.com/nukeykt/NBlood.git source
pushd source
git checkout 5b9fe37
popd

# BUILD PHASE
pushd source
make blood
popd

# COPY PHASE
cp -rfv "source/nblood" "$diststart/common/dist/"
cp -rfv "source/nblood.pk3" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
