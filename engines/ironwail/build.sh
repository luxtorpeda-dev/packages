#!/bin/bash

# CLONE PHASE
git clone https://github.com/andrei-drexler/ironwail.git source
pushd source
git checkout be17f15
popd

# BUILD PHASE
pushd "source/Quake"
make -j "$(nproc)" USE_SDL2=1
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/ironwail/share/quake/id1"
mkdir -p "$diststart/common/dist/ironwail/share/quake/rogue"
mkdir -p "$diststart/common/dist/ironwail/share/quake/hipnotic"
mkdir -p "$diststart/common/dist/ironwail/share/quake/dopa"
mkdir -p "$diststart/common/dist/ironwail/share/quake/mg1"

cp -v source/Quake/ironwail "$diststart/common/dist/ironwail/"
cp -v assets/ironwail.sh "$diststart/common/dist/ironwail/"
cp -v assets/default.lux.cfg "$diststart/common/dist/ironwail/share/quake"

ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/ironwail/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/ironwail/share/quake/id1/pak1.pak"
ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/ironwail/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/ironwail/share/quake/hipnotic/pak0.pak"
ln -s "../../../../rerelease/mg1/pak0.pak" "$diststart/common/dist/ironwail/share/quake/mg1/pak0.pak"
