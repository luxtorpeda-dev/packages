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
    -DJANSSON_BUILD_SHARED_LIBS=ON \
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
    -DJANSSON_LIBRARIES="$pfx/lib/libjansson.so" \
    -DJANSSON_INCLUDE_DIRS="$pfx/include" \
    -DLIBZIP_LIBRARIES="$pfx/lib/libzip.so" \
    -DLIBZIP_INCLUDE_DIRS="$pfx/include" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/285330/dist/lib"
cp -rfv "$pfx/lib".*.so* "$diststart/285330/dist/lib"
cp -rfv "source/build/openrct2" "$diststart/285330/dist/"
cp -rfv "source/build/openrct2-cli" "$diststart/285330/dist/"
