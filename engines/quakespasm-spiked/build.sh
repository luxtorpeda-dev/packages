#!/bin/bash

# CLONE PHASE
git clone https://github.com/Shpoike/Quakespasm.git source
pushd source
git checkout 9ffca1d
popd

git clone https://github.com/markjeee/libmad.git mad
pushd mad
git checkout -f c2f96fa
# from http://www.linuxfromscratch.org/blfs/view/svn/multimedia/libmad.html
patch -Np1 -i ../patches/libmad-0.15.1b-fixes-1.patch
sed "s@AM_CONFIG_HEADER@AC_CONFIG_HEADERS@g" -i configure.ac
touch NEWS AUTHORS ChangeLog
autoreconf -fi
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "mad"
./configure --prefix="$pfx" --disable-static
make -j "$(nproc)" install
popd

pushd "mad"
./configure --disable-static
make -j "$(nproc)" install
popd

pushd "source/quakespasm/Quake"
make -j "$(nproc)" USE_SDL2=1
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/quakespasm/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/common/dist/quakespasm/lib"
mkdir -p "$diststart/common/dist/quakespasm/share/quake/id1"
mkdir -p "$diststart/common/dist/quakespasm/share/quake/rogue"
mkdir -p "$diststart/common/dist/quakespasm/share/quake/hipnotic"
cp -v source/quakespasm/Quake/quakespasm "$diststart/common/dist/quakespasm/"
cp -v assets/quakespasm.sh "$diststart/common/dist/quakespasm/"
cp -v assets/default.lux.cfg "$diststart/common/dist/quakespasm/share/quake"
ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/quakespasm/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/quakespasm/share/quake/id1/pak1.pak"
ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/quakespasm/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/quakespasm/share/quake/hipnotic/pak0.pak"
