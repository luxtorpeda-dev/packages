#!/bin/bash

pstart="$PWD"
readonly tmp="$PWD/tmp"
mkdir -p "$tmp"

# CLONE PHASE
git clone https://github.com/TES3MP/openmw-tes3mp.git source
pushd source
git checkout -f 6895409
git submodule update --init --recursive
popd

# COPY PHASE
cp "assets/tes3mp-launcher.sh" "$diststart/22320/dist/"
cp -rfv source/tes3mp-credits.md "$diststart/22320/dist"
