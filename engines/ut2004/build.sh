#!/bin/bash

# CLONE PHASE
git clone https://github.com/tim241/sdlcl sdlcl
pushd sdlcl
git checkout -f 2d3cc735
popd

# BUILD PHASE
pushd "sdlcl"
make
popd

# COPY PHASE
mkdir -p "$diststart/13230/dist/system"
cp -rfv "assets/run-ut2004.sh" "$diststart/13230/dist/system"
cp -rfv "sdlcl/libSDL-1.2.so.0" "$diststart/13230/dist/"
