#!/bin/bash

# CLONE PHASE
git clone https://github.com/akarnokd/open-ig.git source
pushd source
git checkout 944fb11
popd

# COPY PHASE
cp -rfv assets/* "$diststart/573790/dist/"
