#!/bin/bash

# CLONE PHASE
git clone https://github.com/libunwind/libunwind.git libunwind
pushd libunwind
git checkout -f 5010beb
popd

# BUILD PHASE
pushd libunwind
./autogen.sh
./configure
make
make install
popd

cp -rfv "/usr/local/lib/libunwind"* "/usr/lib"
