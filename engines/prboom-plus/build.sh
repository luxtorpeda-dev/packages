#!/bin/bash

# CLONE PHASE
git clone https://github.com/coelckers/prboom-plus.git source
pushd source
git checkout 9695151
popd

# BUILD PHASE
pushd "source/prboom2"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/prboom2/build/prboom-plus" "$diststart/common/dist/"
cp -rfv "source/prboom2/build/prboom-plus.wad" "$diststart/common/dist/"
cp -rfv "source/prboom2/build/prboom-plus-game-server" "$diststart/common/dist/"

cp -rfv "assets/run-prboom-plus.sh" "$diststart/common/dist/"
