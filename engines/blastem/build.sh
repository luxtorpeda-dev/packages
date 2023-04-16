#!/bin/bash

# CLONE PHASE
hg clone https://www.retrodev.com/repos/blastem source
pushd source
hg update 460e14497120
popd

# BUILD PHASE
pushd source
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$dirstart/34270/dist/emu/"
cp -rfv "source" "$diststart/34270/dist/emu"

cp -rfv "assets/run-blastem.sh" "$diststart/34270/dist/"
