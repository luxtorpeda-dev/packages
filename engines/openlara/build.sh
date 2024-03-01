#!/bin/bash

# CLONE PHASE
git clone https://github.com/XProger/OpenLara.git source
pushd source
git checkout "$COMMIT_HASH"
popd

pushd source/src/platform/nix
./build.sh
popd

# COPY PHASE
cp -rfv source/bin/OpenLara "$diststart/224960/dist"

cp -rfv assets/*.sh "$diststart/224960/dist"
