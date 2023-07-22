#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenMW/openmw source
pushd source
git checkout -f 3b669c2
popd

git clone https://github.com/zesterer/openmw-shaders.git openmw-shaders
pushd openmw-shaders
git checkout 3428a4f
popd

# COPY PHASE
cp assets/* "$diststart/22320/dist/"
cp -rfv openmw-shaders/shaders/* "$diststart/22320/dist/openmw-shaders"
