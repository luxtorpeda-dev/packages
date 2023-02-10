#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/vkquake - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/Novum/vkQuake source
pushd source
git checkout 358e50e
popd

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"

pushd "source/Quake"
make -j "$(nproc)" USE_CODEC_MP3=0
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/share/quake/id1"
mkdir -p "$diststart/common/dist/share/quake/rogue"
mkdir -p "$diststart/common/dist/share/quake/hipnotic"
mkdir -p "$diststart/common/dist/share/quake/dopa"
mkdir -p "$diststart/common/dist/share/quake/rerelease/mg1"
mkdir -p "$diststart/common/dist/share/quake/rerelease/dopa"
mkdir -p "$diststart/common/dist/share/quake/rerelease/id1"
mkdir -p "$diststart/common/dist/share/quake/rerelease/rogue"
mkdir -p "$diststart/common/dist/share/quake/rerelease/hipnotic"

cp -v source/Quake/vkquake "$diststart/common/dist/"
cp -v assets/vkquake.sh "$diststart/common/dist/"
cp -v assets/default.lux.cfg "$diststart/common/dist/share/quake"

ln -s "../../../id1/PAK0.PAK" "$diststart/common/dist/share/quake/id1/pak0.pak"
ln -s "../../../id1/PAK1.PAK" "$diststart/common/dist/share/quake/id1/pak1.pak"
ln -s "../../../rogue/pak0.pak" "$diststart/common/dist/share/quake/rogue/pak0.pak"
ln -s "../../../hipnotic/pak0.pak" "$diststart/common/dist/share/quake/hipnotic/pak0.pak"
ln -s "../../../../rerelease/mg1/pak0.pak" "$diststart/common/dist/share/quake/rerelease/mg1/pak0.pak"
ln -s "../../../../rerelease/id1/pak0.pak" "$diststart/common/dist/share/quake/rerelease/id1/pak0.pak"
ln -s "../../../../rerelease/rogue/pak0.pak" "$diststart/common/dist/share/quake/rerelease/rogue/pak0.pak"
ln -s "../../../../rerelease/hipnotic/pak0.pak" "$diststart/common/dist/share/quake/rerelease/hipnotic/pak0.pak"
ln -s "../../../../rerelease/dopa/pak0.pak" "$diststart/common/dist/share/quake/rerelease/dopa/pak0.pak"
