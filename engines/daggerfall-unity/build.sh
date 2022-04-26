#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interkarma/daggerfall-unity.git source
pushd source
git checkout 5b908a8
popd


# COPY PHASE
cp -rfv assets/* "$diststart/1812390/dist"
