#!/bin/bash

# CLONE PHASE
git clone https://github.com/DarkPlacesEngine/darkplaces.git source
pushd source
git checkout -f 901c2dc
popd

# BUILD PHASE
pushd "source"
make -j "$(nproc)" sdl-release
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/darkplaces/share/quake/id1"
mkdir -p "$diststart/common/dist/darkplaces/share/quake/rogue"
mkdir -p "$diststart/common/dist/darkplaces/share/quake/hipnotic"
mkdir -p "$diststart/common/dist/darkplaces/share/quake/dopa"
mkdir -p "$diststart/common/dist/darkplaces/share/quake/mg1"

cp -v source/darkplaces-sdl "$diststart/common/dist/darkplaces/"
cp -v assets/darkplaces.sh "$diststart/common/dist/darkplaces/"

cp -v assets/default.lux.cfg "$diststart/common/dist/darkplaces/share/quake"

ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/darkplaces/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/darkplaces/share/quake/id1/pak1.pak"

ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/darkplaces/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/darkplaces/share/quake/hipnotic/pak0.pak"
ln -s "../../../../rerelease/mg1/pak0.pak" "$diststart/common/dist/darkplaces/share/quake/mg1/pak0.pak"
