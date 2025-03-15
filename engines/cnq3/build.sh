#!/bin/bash

# CLONE PHASE
git clone https://bitbucket.org/CPMADevs/cnq3.git source
pushd source
git checkout "$COMMIT_TAG"
popd


# BUILD PHASE
pushd "source"
QUAKE3DIR="$PWD" make config=release client
popd

# COPY PHASE
cp -rfv source/.bin/release_x64/cnq3-x64 "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
