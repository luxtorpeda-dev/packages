#!/bin/bash

# CLONE PHASE
git clone https://github.com/grandseiken/byacc.git byacc
pushd byacc
git checkout -f 4265cbd
popd

# BUILD PHASE
pushd "byacc"
make -j "$(nproc)" install
popd
