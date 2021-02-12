#!/bin/bash

# CLONE PHASE
git clone https://github.com/sezero/uhexen2.git source
pushd source
git checkout fdf6f72
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

pushd "source/engine/hexen2"
make -j "$(nproc)" glh2
popd

# COPY PHASE
mkdir -p "$diststart/9060/dist/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/9060/dist/lib"
cp -rfv "./source/engine/hexen2/glhexen2" "$diststart/9060/dist"
