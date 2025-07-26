#!/bin/bash

export CXXFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export CFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/Henrique194/chocolate-quake.git source
pushd source
git checkout "$COMMIT_HASH"
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" ..
cmake --build .
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/chocolate-quake/share/quake/id1"
mkdir -p "$diststart/common/dist/chocolate-quake/share/quake/rogue"
mkdir -p "$diststart/common/dist/chocolate-quake/share/quake/hipnotic"

cp -v source/build/src/chocolate-quake "$diststart/common/dist/chocolate-quake/"
cp -v assets/chocolate-quake.sh "$diststart/common/dist/chocolate-quake/"

ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/chocolate-quake/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/chocolate-quake/share/quake/id1/pak1.pak"
ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/chocolate-quake/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/chocolate-quake/share/quake/hipnotic/pak0.pak"
