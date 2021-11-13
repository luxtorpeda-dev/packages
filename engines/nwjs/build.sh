#!/bin/bash

# CLONE PHASE
git clone https://github.com/nwjs/nw.js.git source
pushd source
git checkout f110a6a
popd

# COPY PHASE
cp -rfv assets/* "$diststart/common/dist/"
