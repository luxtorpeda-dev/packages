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
mkdir -p "$diststart/2310/dist/darkplaces/share/quake/id1"
cp -v source/darkplaces/darkplaces-sdl "$diststart/2310/dist/darkplaces/"
cp -v assets/darkplaces.sh "$diststart/2310/dist/darkplaces/"
cp -v assets/default.lux.cfg "$diststart/2310/dist/darkplaces/share/quake"
ln -s "../../../../Id1/PAK0.PAK" "$diststart/2310/dist/darkplaces/share/quake/id1/pak0.pak"
ln -s "../../../../Id1/PAK1.PAK" "$diststart/2310/dist/darkplaces/share/quake/id1/pak1.pak"
