#!/bin/bash

# CLONE PHASE
git clone https://github.com/KleskBY/ObjectN-DarkPlaces-engine.git source
pushd source
git checkout -f de3b618
git am < ../patches/0001-Remove-nuklear-menu.patch
popd

# BUILD PHASE
pushd "source"
make -j "$(nproc)" sdl-release
popd

# COPY PHASE
cp -v source/darkplaces-sdl "$diststart/1508030/dist/"

cp -v assets/objectn.sh "$diststart/1508030/dist/"
