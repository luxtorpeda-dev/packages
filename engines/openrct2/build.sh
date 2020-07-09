#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenRCT2/OpenRCT2.git source
pushd source
git checkout -f 6c3c857
popd

git clone https://github.com/akheron/jansson.git jansson
pushd jansson
git checkout -f e9ebfa7
popd

git clone https://github.com/nih-at/libzip.git libzip
pushd libzip
git checkout -f dcd9a0b
popd

git clone https://github.com/unicode-org/icu.git icu
pushd icu
git checkout -f c8bc56e
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd jansson
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd libzip
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd icu/icu4c/source
./runConfigureICU Linux --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd source
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_CXX_FLAGS="-Wno-sign-compare" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
