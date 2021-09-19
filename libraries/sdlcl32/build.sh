#!/bin/bash

# CLONE PHASE
git clone https://github.com/MrAlert/sdlcl.git sdlcl
pushd sdlcl
git checkout -f 85ca5537ac2a067d4c0e2fd67dd17ab6bde4359e
git am < ../patches/0001-Force-32-bit.patch
popd

# BUILD PHASE
pushd "sdlcl"
make -j "$(nproc)"
popd

# COPY PHASE
#cp -rfv assets/* "$diststart/10050/dist/"
#cp -rfv "sdlcl/libSDL-1.2.so.0" "$diststart/10050/dist/"
