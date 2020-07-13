#!/bin/bash

# CLONE PHASE
git clone https://github.com/tim241/sdlcl sdlcl
pushd sdlcl
git checkout -f 2d3cc735
popd

# BUILD PHASE
pushd "sdlcl"
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "assets/run-prey.sh" "$diststart/3970/dist/"
cp -rfv "assets/setup-prey.sh" "$diststart/3970/dist/"
cp -rfv "assets/uninstall-prey.sh" "$diststart/3970/dist/"
cp -rfv "sdlcl/libSDL-1.2.so.0" "$diststart/3970/dist/"
