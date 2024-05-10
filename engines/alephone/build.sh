#!/bin/bash

# CLONE PHASE
git clone https://github.com/Aleph-One-Marathon/alephone.git source
pushd source
git checkout -f "$COMMIT_TAG"
git submodule update --init --recursive
popd

# BUILD PHASE
autoreconf -i
./configure
make dist
popd

# COPY PHASE
cp -rfv assets/* "$diststart/2398450/dist/"
