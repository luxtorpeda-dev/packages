#!/bin/bash

# CLONE PHASE
git clone https://github.com/Rubberduckycooly/Sonic-CD-11-Decompilation.git source
pushd source
git checkout -f e0011d7
popd

# BUILD PHASE

pushd "source"
make
popd

# COPY PHASE
cp -rfv "source/soniccd" "$diststart/200940/dist/"
