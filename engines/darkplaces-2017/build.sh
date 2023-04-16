#!/bin/bash

# CLONE PHASE
wget http://icculus.org/twilight/darkplaces/files/darkplacesengine20170829beta1.zip
mkdir ./source
pushd source
unzip ../darkplacesengine20170829beta1.zip
unzip darkplacesenginesource20170829beta1.zip
popd

# BUILD PHASE
pushd "source/darkplaces"
make -j "$(nproc)" sdl-release
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/darkplaces-2017/share/quake/id1"
mkdir -p "$diststart/common/dist/darkplaces-2017/share/quake/rogue"
mkdir -p "$diststart/common/dist/darkplaces-2017/share/quake/hipnotic"
mkdir -p "$diststart/common/dist/darkplaces-2017/share/quake/dopa"
mkdir -p "$diststart/common/dist/darkplaces-2017/share/quake/mg1"

cp -v source/darkplaces/darkplaces-sdl "$diststart/common/dist/darkplaces-2017/"
cp -v assets/darkplaces.sh "$diststart/common/dist/darkplaces-2017/"
cp -v assets/default.lux.cfg "$diststart/common/dist/darkplaces-2017/share/quake"

ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/darkplaces-2017/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/darkplaces-2017/share/quake/id1/pak1.pak"

ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/darkplaces-2017/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/darkplaces-2017/share/quake/hipnotic/pak0.pak"
ln -s "../../../../rerelease/mg1/pak0.pak" "$diststart/common/dist/darkplaces-2017/share/quake/mg1/pak0.pak"
