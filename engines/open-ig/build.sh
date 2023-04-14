#!/bin/bash

# CLONE PHASE
git clone https://github.com/akarnokd/open-ig.git source
pushd source
git checkout 8f58a81
popd

# COPY PHASE

cp -rfv assets/* "$diststart/573790/dist/"
