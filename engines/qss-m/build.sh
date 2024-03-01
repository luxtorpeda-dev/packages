#!/bin/bash

export CXXFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export CFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/timbergeron/QSS-M.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd "source/Quake"
export QSS_CFLAGS="-DQSS_REVISION=`git rev-parse HEAD`"
export QSS_LDFLAGS="-Wl,--allow-multiple-definition"
make -j "$(nproc)" USE_SDL2=1
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/qss-m/share/quake/id1"
mkdir -p "$diststart/common/dist/qss-m/share/quake/rogue"
mkdir -p "$diststart/common/dist/qss-m/share/quake/hipnotic"
mkdir -p "$diststart/common/dist/qss-m/share/quake/dopa"
mkdir -p "$diststart/common/dist/qss-m/share/quake/mg1"

cp -v source/Quake/quakespasm "$diststart/common/dist/qss-m/qss-m"
cp -v assets/qss-m.sh "$diststart/common/dist/qss-m/"
cp -v assets/default.lux.cfg "$diststart/common/dist/qss-m/share/quake"

ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/qss-m/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/qss-m/share/quake/id1/pak1.pak"
ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/qss-m/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/qss-m/share/quake/hipnotic/pak0.pak"
ln -s "../../../../rerelease/mg1/pak0.pak" "$diststart/common/dist/qss-m/share/quake/mg1/pak0.pak"
