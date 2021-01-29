#!/bin/bash

# CLONE PHASE
git clone https://github.com/Shpoike/Quakespasm.git source
pushd source
git checkout 9ffca1d
popd

# BUILD PHASE
pushd "source/quakespasm/Quake"
make -j "$(nproc)" USE_SDL2=1
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/quakespasm/share/quake/id1"
mkdir -p "$diststart/common/dist/quakespasm/share/quake/rogue"
mkdir -p "$diststart/common/dist/quakespasm/share/quake/hipnotic"
cp -v source/quakespasm/Quake/quakespasm "$diststart/common/dist/quakespasm/"
cp -v assets/quakespasm.sh "$diststart/common/dist/quakespasm/"
cp -v assets/quakespasm-rogue.sh "$diststart/common/dist/quakespasm/"
cp -v assets/quakespasm-hipnotic.sh "$diststart/common/dist/quakespasm/"
cp -v assets/default.lux.cfg "$diststart/common/dist/quakespasm/share/quake"
ln -s "../../../../Id1/PAK0.PAK" "$diststart/common/dist/quakespasm/share/quake/id1/pak0.pak"
ln -s "../../../../Id1/PAK1.PAK" "$diststart/common/dist/quakespasm/share/quake/id1/pak1.pak"
ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/quakespasm/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/quakespasm/share/quake/hipnotic/pak0.pak"
