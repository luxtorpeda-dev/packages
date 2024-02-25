#!/bin/bash

# CLONE PHASE
git clone https://git.code.sf.net/p/sc2/uqm source
pushd source
git checkout 102099
popd

# BUILD PHASE
cp -rfv ./config.state source/sc2
pushd "source/sc2"
./build.sh uqm reprocess_config
./build.sh uqm
popd

# COPY PHASE
cp -v source/obj/debug/src/uqm "$diststart/2645580/dist/"
cp -v assets/sc2.sh "$diststart/2645580/dist/"
