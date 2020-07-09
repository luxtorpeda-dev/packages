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

git clone https://github.com/glennrp/libpng.git libpng
pushd libpng
git checkout -f c17d164
popd

wget https://github.com/OpenRCT2/objects/releases/download/v1.0.15/objects.zip
wget https://github.com/OpenRCT2/title-sequences/releases/download/v0.1.2c/title-sequences.zip

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

pushd libpng
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
    -DJANSSON_LIBRARIES="$pfx/lib/libjansson.so" \
    -DJANSSON_INCLUDE_DIRS="$pfx/include" \
    -DLIBZIP_LIBRARIES="$pfx/lib/libzip.so" \
    -DLIBZIP_INCLUDE_DIRS="$pfx/include" \
    -DPNG_LIBRARIES="$pfx/lib/libpng16.so" \
    -DPNG_INCLUDE_DIRS="$pfx/include" \
    ..
make -j "$(nproc)"
cp -rfv ../data .
make g2
popd

# COPY PHASE
mkdir -p "$diststart/285330/dist/lib"
mkdir -p "$diststart/285330/dist/data/object"
cp -rfv "$pfx/lib/"*.so* "$diststart/285330/dist/lib"
cp -rfv "source/build/openrct2" "$diststart/285330/dist/"
cp -rfv "source/build/openrct2-cli" "$diststart/285330/dist/"
cp -rfv "source/build/data/"* "$diststart/285330/dist/data"
cp -rfv "source/build/g2.dat" "$diststart/285330/dist/data"
cp -rfv "assets/run-openrct2.sh" "$diststart/285330/dist"

unzip objects.zip -d "$diststart/285330/dist/data/object"
unzip title-sequences.zip -d "$diststart/285330/dist/data/title"
