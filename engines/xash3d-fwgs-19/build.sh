#!/bin/bash

# CLONE PHASE
git clone https://github.com/FWGS/xash3d.git source
pushd xash3d
git checkout -f 33f9fe8
popd

# COPY PHASE
cp -rfv assets/* "$diststart/812440/dist/"
