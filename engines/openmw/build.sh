#!/bin/bash

readonly tmp="$PWD/tmp"
mkdir -p "$pfx"

# CLONE PHASE
git clone https://github.com/OpenMW/openmw source
pushd source
git checkout -f bac679d
git submodule update --init --recursive
git am < ../patches/0001-Fix-compile-error.patch
popd

git clone https://github.com/recastnavigation/recastnavigation recastnavigation
pushd recastnavigation
git checkout -f c5cbd53024c8a9d8d097a4371215e3342d2fdc87
popd
# BUILD PHASE
pushd recastnavigation
mkdir -p build
cd build
cmake \
    -DRECASTNAVIGATION_DEMO=no \
    -DRECASTNAVIGATION_TESTS=no \
    -DRECASTNAVIGATION_EXAMPLES=no \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
 make install
popd

pushd "source"
mkdir -p build
cd build
export OSG_DIR="$pfx/lib64"
cmake \
    -DBUILD_LAUNCHER=ON \
    -DDESIRED_QT_VERSION=5 \
    -DBUILD_OPENCS=OFF \
    -DBUILD_WIZARD=ON \
    -DBUILD_MYGUI_PLUGIN=OFF \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    -DOPENMW_USE_SYSTEM_RECASTNAVIGATION=yes \
    ..
make -j "$(nproc)"
DESTDIR="$tmp" make install
popd

# COPY PHASE
mkdir -p "$diststart/22320/dist/lib/"
cp -rfv "$pfx/"lib/*.so* "$diststart/22320/dist/lib/"
cp -rfv "$pfx/lib/"osgPlugins-* "$diststart/22320/dist/lib/"
cp -rfv "$tmp/usr/local/"{etc,share} "$diststart/22320/dist/"
cp -rfv "$tmp/usr/local/bin/"* "$diststart/22320/dist/"
cp assets/* "$diststart/22320/dist/"
cp "source/files/settings-default.cfg" "$diststart/22320/dist/"
cp -rfv source/build/defaults.bin "$diststart/22320/dist/"
