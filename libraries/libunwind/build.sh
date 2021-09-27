#!/bin/bash

# CLONE PHASE
git clone https://github.com/libunwind/libunwind.git libunwind
pushd libunwind
git checkout -f 1847559
git am < ../patches/0001-Workaround-for-force-link-of-lgcc.patch
popd

# BUILD PHASE
pushd libunwind
./autogen.sh
./configure
make
make install
popd

cp -rfv "/usr/local/lib/libunwind"* "/usr/lib"
