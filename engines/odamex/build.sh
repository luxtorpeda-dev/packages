#!/bin/bash

# CLONE PHASE
git clone https://github.com/odamex/odamex.git source
pushd source
git checkout "$COMMIT_TAG"
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DUSE_INTERNAL_CPPTRACE=1 \
    -DUSE_INTERNAL_ZSTD=1 \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/client/odamex" "$diststart/common/dist/"
chmod +x "$diststart/common/dist/odamex"
cp -rfv "source/build/client/odamex.wad" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
