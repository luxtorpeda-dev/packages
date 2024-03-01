#!/bin/bash

# CLONE PHASE
git clone https://github.com/nwjs/nw.js.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# COPY PHASE
cp -rfv assets/* "$diststart/common/dist/"
