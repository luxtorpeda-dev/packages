#!/bin/bash

export CXXFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export CFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/Shpoike/Quakespasm.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd "source/Quake"
make -j "$(nproc)" USE_SDL2=1
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/quakespasm/share/quake/id1"
mkdir -p "$diststart/common/dist/quakespasm/share/quake/rogue"
mkdir -p "$diststart/common/dist/quakespasm/share/quake/hipnotic"
mkdir -p "$diststart/common/dist/quakespasm/share/quake/dopa"
mkdir -p "$diststart/common/dist/quakespasm/share/quake/mg1"
cp -v source/Quake/quakespasm "$diststart/common/dist/quakespasm/"
cp -v assets/quakespasm.sh "$diststart/common/dist/quakespasm/"
cp -v assets/default.lux.cfg "$diststart/common/dist/quakespasm/share/quake"

ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/quakespasm/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/quakespasm/share/quake/id1/pak1.pak"
ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/quakespasm/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/quakespasm/share/quake/hipnotic/pak0.pak"
ln -s "../../../../rerelease/mg1/pak0.pak" "$diststart/common/dist/quakespasm/share/quake/mg1/pak0.pak"
