#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interkarma/daggerfall-unity.git source
pushd source
git checkout 6219fc0
popd


# COPY PHASE
cp -rfv assets/* "$diststart/1812390/dist"
