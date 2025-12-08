#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information
# CLONE PHASE
git clone https://github.com/Waffle-Iron-Studios/Griddle.git source
pushd source
git checkout "$COMMIT_HASH"
popd

git clone https://github.com/coelckers/ZMusic.git zmusic
pushd zmusic
git checkout -f ac3e232
popd

# BUILD PHASE
pushd "zmusic"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/griddle "$diststart/common/dist/gzdoom"
cp -rfv "source/build"/{soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv source/build/*.so* "$diststart/common/dist/lib"
cp -rfv assets/* "$diststart/common/dist/"
ln -rsf "$diststart/common/dist/lib/libfluidsynth.so.3" "$diststart/common/dist/lib/libfluidsynth.so.2"
