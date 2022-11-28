#!/bin/bash

sudo apt-get -y install lld

# CLONE PHASE
git clone https://github.com/clipmove/NotBlood.git source
pushd source
git checkout 09c193f
popd

# BUILD PHASE
pushd source
make blood CLANG=1
popd

# COPY PHASE
cp -rfv "source/notblood" "$diststart/common/dist/"
cp -rfv "source/notblood.pk3" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
