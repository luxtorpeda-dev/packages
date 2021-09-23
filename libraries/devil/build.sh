#!/bin/bash

# CLONE PHASE
git clone https://github.com/DentonW/DevIL.git devil
pushd devil
git checkout -f a2d9193
popd

# BUILD PHASE
pushd "devil/DevIL"
mkdir build
cd build || exit 1
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/include/"* "/usr/include"
cp -rfv "$pfx/lib/"* "/usr/lib"
