#!/bin/bash

# CLONE PHASE
git clone https://github.com/ezQuake/ezquake-source.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd "source/"
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/ezquake/share/quake/id1"
mkdir -p "$diststart/common/dist/ezquake/share/quake/rogue"
mkdir -p "$diststart/common/dist/ezquake/share/quake/hipnotic"
mkdir -p "$diststart/common/dist/ezquake/share/quake/dopa"
mkdir -p "$diststart/common/dist/ezquake/share/quake/mg1"

cp -v source/ezquake-linux-x86_64 "$diststart/common/dist/ezquake/"
cp -v assets/ezquake.sh "$diststart/common/dist/ezquake/"
ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/ezquake/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/ezquake/share/quake/id1/pak1.pak"
ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/ezquake/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/ezquake/share/quake/hipnotic/pak0.pak"
ln -s "../../../../rerelease/mg1/pak0.pak" "$diststart/common/dist/ezquake/share/quake/mg1/pak0.pak"
