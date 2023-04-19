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
wget https://github.com/TES3MP/TES3MP/releases/download/tes3mp-0.8.1/tes3mp-GNU+Linux-x86_64-release-0.8.1-68954091c5-6da3fdea59.tar.gz
tar xvf tes3mp-GNU+Linux-x86_64-release-0.8.1-68954091c5-6da3fdea59.tar.gz
rm -rf TES3MP/_deps
cp -rfv TES3MP/* "$diststart/22320/dist/"

cp "assets/tes3mp-launcher.sh" "$diststart/22320/dist/"
cp -rfv source/tes3mp-credits.md "$diststart/22320/dist"
