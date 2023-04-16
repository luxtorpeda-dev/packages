#!/bin/bash

# CLONE PHASE
git clone https://gitlab.com/solarus-games/solarus.git source
pushd source
git checkout 3aec70b0
popd

git clone https://github.com/Konstanty/libmodplug.git libmodplug
pushd libmodplug
git checkout d1b97ed
popd

# BUILD PHASE
pushd "libmodplug"
autoreconf --install
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DSOLARUS_TESTS=OFF \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DSOLARUS_GUI=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/1393750/dist/lib"
cp -rfv "assets/run-ocean-heart.sh" "$diststart/1393750/dist/"
cp -rfv "$pfx/bin/solarus-run" "$diststart/1393750/dist/"
cp -rfv "$pfx/lib/"*.so* "$diststart/1393750/dist/lib/"
