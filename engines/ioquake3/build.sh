#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/ioq3 - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/ioquake/ioq3.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd "source"
make -j "$(nproc)"
popd

# COPY PHASE
COPYDIR="$diststart/common/dist/" make --directory="source" copyfiles
cp -rfv assets/* "$diststart/common/dist/"
