#!/bin/bash

# CLONE PHASE
git clone https://github.com/ec-/Quake3e.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd "source"

make -j "$(nproc)"
make install DESTDIR="$diststart/common/dist/"
popd
