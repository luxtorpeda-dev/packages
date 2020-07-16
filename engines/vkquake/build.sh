#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/vkquake - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/Novum/vkQuake source
pushd source
git checkout e28a2b0
popd

# BUILD PHASE
pushd "source/Quake"
make -j "$(nproc)" USE_CODEC_MP3=0
popd

# COPY PHASE
mkdir -p "$diststart/2310/dist/share/quake/id1"
cp -v source/Quake/vkquake "$diststart/$app_id/dist/"
cp -v assets/vkquake.sh "$diststart/$app_id/dist/"
cp -v assets/default.lux.cfg "$diststart/$app_id/dist/share/quake"
ln -s "../../../Id1/PAK0.PAK" "$diststart/2310/dist/share/quake/id1/pak0.pak"
ln -s "../../../Id1/PAK1.PAK" "$diststart/2310/dist/share/quake/id1/pak1.pak"
