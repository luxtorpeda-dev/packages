#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interkarma/daggerfall-unity.git source
pushd source
git checkout a821774
popd


# COPY PHASE
cp -rfv assets/* "$diststart/1812390/dist"
