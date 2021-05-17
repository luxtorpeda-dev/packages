#!/bin/bash

# CLONE PHASE
git clone https://github.com/MrAlert/sdlcl.git sdlcl
pushd sdlcl
git checkout -f f7530d684bc7867e05e2e71385a452f26ba29555
popd

# BUILD PHASE
pushd "sdlcl"
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv assets/* "$diststart/10050/dist/"
cp -rfv "sdlcl/libSDL-1.2.so.0" "$diststart/10050/dist/"
