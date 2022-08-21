#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interkarma/daggerfall-unity.git source
pushd source
git checkout 2e4ab8b
popd


# COPY PHASE
cp -rfv assets/* "$diststart/1812390/dist"
