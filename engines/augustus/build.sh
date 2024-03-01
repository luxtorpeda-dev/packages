#!/bin/bash

# CLONE PHASE
git clone https://github.com/Keriew/augustus.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake ..
make -j "$(nproc)"
popd

pushd "source"
mkdir -p res/asset_packer/build
pushd res/asset_packer/build
cmake -DCMAKE_BUILD_TYPE=Release $DISABLE_SYSTEM_LIBS  ..
make -j "$(nproc)"
./asset_packer ../../
popd
popd

# COPY PHASE
mkdir -p "$diststart/517790/dist/assets"
cp -rfv "source/build/augustus" "$diststart/517790/dist/"
cp -rfv "source/res/packed_assets/"* "$diststart/517790/dist/assets"
cp -rfv "source/res/maps" "$diststart/517790/dist/"

cp -rfv assets/* "$diststart/517790/dist/"
