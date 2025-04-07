#!/bin/bash

# CLONE PHASE
git clone https://github.com/GardensOfKadesh/Homeworld.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd "source"
meson setup build
meson compile -C build
popd

# COPY PHASE
cp -rfv "source/build/homeworld" "$diststart/244160/dist/"
cp -rfv assets/* "$diststart/244160/dist/"
