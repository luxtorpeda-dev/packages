#!/bin/bash

# CLONE PHASE
git clone https://github.com/KleskBY/ObjectN-DarkPlaces-engine.git source
pushd source
rm -rf SDL
rm -rf curl
popd

# BUILD PHASE
pushd "source"
make -j "$(nproc)" sdl-release
popd

# COPY PHASE
cp -v source/darkplaces-sdl "$diststart/1508030/dist/"
cp -v assets/objectn.sh "$diststart/1508030/dist/"
