#!/bin/bash

# CLONE PHASE
git clone https://github.com/timbergeron/QSS-M.git source
pushd source
git checkout e6a5233
popd

# BUILD PHASE
pushd "source/Quake"
make -j "$(nproc)" USE_SDL2=1
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/qss-m/share/quake/id1"
mkdir -p "$diststart/common/dist/qss-m/share/quake/rogue"
mkdir -p "$diststart/common/dist/qss-m/share/quake/hipnotic"
mkdir -p "$diststart/common/dist/qss-m/share/quake/dopa"
mkdir -p "$diststart/common/dist/qss-m/share/quake/mg1"

cp -v source/Quake/qss-m "$diststart/common/dist/qss-m/"
cp -v assets/qss-m.sh "$diststart/common/dist/qss-m/"
cp -v assets/default.lux.cfg "$diststart/common/dist/qss-m/share/quake"

ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/qss-m/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/qss-m/share/quake/id1/pak1.pak"
ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/qss-m/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/qss-m/share/quake/hipnotic/pak0.pak"
ln -s "../../../../rerelease/mg1/pak0.pak" "$diststart/common/dist/qss-m/share/quake/mg1/pak0.pak"
