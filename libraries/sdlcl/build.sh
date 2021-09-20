#!/bin/bash

# CLONE PHASE
git clone https://github.com/MrAlert/sdlcl.git sdlcl
pushd sdlcl
git checkout -f 85ca5537ac2a067d4c0e2fd67dd17ab6bde4359e
popd

# BUILD PHASE
pushd "sdlcl"
make -j "$(nproc)"
popd
