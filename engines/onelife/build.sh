#!/bin/bash

sudo apt-get -y install imagemagick

# CLONE PHASE
git clone https://github.com/jasonrohrer/OneLife.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
cp -rfv "$pfx/include/"* /usr/include/

pushd "source"
cd build/source/OneLife_Live_UnixSource
./pullAndBuildLatest
popd

# COPY PHASE
cp -rfv source/build/source/OneLife_Live_UnixSource/* "$diststart/595690/dist/"
cp -rfv "assets/"* "$diststart/595690/dist/"
