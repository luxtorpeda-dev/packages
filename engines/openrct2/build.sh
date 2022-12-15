#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenRCT2/OpenRCT2.git source
pushd source
git checkout -f 285e0fc
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DDUKTAPE_LIBRARY="$pfx/lib/libduktape.so" \
    -DDUKTAPE_INCLUDE_DIR="$pfx/include" \
    -DICU_ROOT="$pfx" \
    -DJANSSON_LIBRARIES="$pfx/lib/libjansson.so" \
    -DLIBZIP_LIBRARIES="$pfx/lib/libzip.so" \
    -DCMAKE_INSTALL_PREFIX="$pfx/openrct2" \
    ..
make -j "$(nproc)"
cp -rfv ../data .
make g2
make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/data/object"

cp -rfv "source/build/openrct2" "$diststart/common/dist/"
cp -rfv "source/build/openrct2-cli" "$diststart/common/dist/"
cp -rfv "source/build/data/"* "$diststart/common/dist/data"
cp -rfv "source/build/g2.dat" "$diststart/common/dist/data"
cp -rfv "assets/run-openrct2.sh" "$diststart/common/dist"
cp -rfv "assets/setup-rct1.sh" "$diststart/common/dist"
cp -rfv "assets/setup-rct2.sh" "$diststart/common/dist"
cp -rfv "$pfx/openrct2/share/openrct2/"* "$diststart/common/dist/data"
