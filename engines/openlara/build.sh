#!/bin/bash

# CLONE PHASE
git clone https://github.com/XProger/OpenLara.git source
pushd source
git checkout b7d6ce5
git am < ../patches/0001-Fix-compile-error.patch
popd

pushd source/src/platform/nix
./build.sh
popd

# COPY PHASE
cp -rfv source/bin/OpenLara "$diststart/224960/dist/lib"
