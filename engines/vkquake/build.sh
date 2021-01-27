#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/vkquake - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/Novum/vkQuake source
pushd source
git checkout 7ec2ccb
popd

# BUILD PHASE
pushd "source/Quake"
make -j "$(nproc)" USE_CODEC_MP3=0
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/share/quake/id1"
mkdir -p "$diststart/common/dist/share/quake/rogue"
mkdir -p "$diststart/common/dist/share/quake/hipnotic"
cp -v source/Quake/vkquake "$diststart/common/dist/"
cp -v assets/vkquake.sh "$diststart/common/dist/"
cp -v assets/vkquake-rogue.sh "$diststart/common/dist/"
cp -v assets/vkquake-hipnotic.sh "$diststart/common/dist/"
cp -v assets/default.lux.cfg "$diststart/common/dist/share/quake"
ln -s "../../../Id1/PAK0.PAK" "$diststart/common/dist/share/quake/id1/pak0.pak"
ln -s "../../../Id1/PAK1.PAK" "$diststart/common/dist/share/quake/id1/pak1.pak"
ln -s "../../../rogue/pak0.PAK" "$diststart/common/dist/share/quake/rogue/pak0.pak"
ln -s "../../../hipnotic/pak0.PAK" "$diststart/common/dist/share/quake/hipnotic/pak0.pak"
