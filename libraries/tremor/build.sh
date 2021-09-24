#!/bin/bash

# CLONE PHASE
git clone https://gitlab.xiph.org/xiph/tremor.git
pushd tremor
git checkout -f 7c30a66346199f3f09017a09567c6c8a3a0eedc8
popd

# BUILD PHASE
pushd "tremor"
./autogen.sh
make
make install
popd
