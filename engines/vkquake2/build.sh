#!/bin/bash

# CLONE PHASE
git clone https://github.com/kondrak/vkQuake2.git source
pushd source
git checkout 3b8fbff
popd

# BUILD PHASE
pushd "source"
cd linux
make -j "$(nproc)" release
popd

# COPY PHASE
cp -rfv "source/linux/releasex64/"* "$diststart/common/dist/"
