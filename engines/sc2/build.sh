#!/bin/bash

# CLONE PHASE
git clone https://git.code.sf.net/p/sc2/uqm source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
cp -rfv ./config.state source/sc2
pushd "source/sc2"
./build.sh uqm reprocess_config
./build.sh uqm
./build.sh uqm install
popd

# COPY PHASE
cp -v /usr/local/games/lib/uqm/uqm "$diststart/2645580/dist/"
cp -v assets/sc2.sh "$diststart/2645580/dist/"
