#!/bin/bash

# CLONE PHASE
git clone https://github.com/hessu/bchunk.git bchunk
pushd bchunk
git checkout -f 2d46931
popd

# BUILD PHASE
pushd bchunk
make
popd
