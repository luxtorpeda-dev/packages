#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interkarma/daggerfall-unity.git source
pushd source
git checkout "$COMMIT_TAG"
popd


# COPY PHASE
cp -rfv assets/* "$diststart/1812390/dist"
