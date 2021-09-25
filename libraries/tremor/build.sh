#!/bin/bash

# CLONE PHASE
git clone https://github.com/soundcloud/tremor.git
pushd tremor
git checkout -f 68fe46c
popd

# BUILD PHASE
pushd "tremor"
./autogen.sh
make
make install
popd
