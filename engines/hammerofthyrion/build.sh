#!/bin/bash

# CLONE PHASE
git clone https://github.com/sezero/uhexen2.git source
pushd source
git checkout fdf6f72
popd

# BUILD PHASE
pushd "source/engine/hexen2"
make -j "$(nproc)" h2
popd

# COPY PHASE
