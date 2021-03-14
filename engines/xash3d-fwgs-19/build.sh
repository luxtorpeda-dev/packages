#!/bin/bash

# CLONE PHASE
git clone https://github.com/FWGS/xash3d.git source
pushd source
git checkout -f 33f9fe8
popd

# COPY PHASE
cp -rfv assets/absolute-zero/* "$diststart/812440/dist/"
cp -rfv assets/before/* "$diststart/261980/dist/"
