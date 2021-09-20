#!/bin/bash

# CLONE PHASE
git clone https://github.com/libunwind/libunwind.git libunwind
pushd libunwind
git checkout -f 1847559
popd

# BUILD PHASE
pushd libunwind
./autogen.sh
./configure
make
make install
popd
