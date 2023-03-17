#!/bin/bash

# CLONE PHASE
git clone https://github.com/curl/curl.git curl
pushd curl
git checkout -f curl-7_88_1
popd

# BUILD PHASE
pushd "curl"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

cp -rfv "$pfx/usr/local/lib/"* /usr/lib/x86_64-linux-gnu
cp -rfv "$pfx/usr/local/include/"* /usr/include/x86_64-linux-gnu
