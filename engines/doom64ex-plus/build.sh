#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information
# CLONE PHASE
git clone https://github.com/atsb/Doom64EX-Plus.git source
pushd source
git checkout 8e705b8
popd

# BUILD PHASE
pushd "source/src/engine"
./build.sh
popd

# COPY PHASE
cp -rfv source/src/engine/DOOM64EX-Plus "$diststart/1148590/dist/"
cp -rfv assets/* "$diststart/1148590/dist/"
cp -rfv source/doomsnd.sf2 "$diststart/1148590/dist/"
cp -rfv source/doom64ex-plus.wad "$diststart/1148590/dist/"
