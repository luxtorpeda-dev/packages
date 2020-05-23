#!/bin/bash

# CLONE PHASE
git clone --recursive https://github.com/OpenMW/openmw source
pushd source
git checkout e29e3248
popd

git clone --recursive https://github.com/boostorg/boost boost
pushd boost
git checkout afb333b7
popd

git clone --recursive https://github.com/bulletphysics/bullet3 bullet3
pushd bullet3
git checkout 6e4707df
popd

git clone --recursive https://github.com/FFmpeg/FFmpeg ffmpeg
pushd ffmpeg
git checkout 523da8ea
popd

git clone --recursive https://github.com/MyGUI/mygui mygui
pushd mygui
git checkout 8a05127d
popd

git clone --recursive https://github.com/OpenMW/osg osg
pushd osg
git checkout d69f2a81
popd

# BUILD PHASE

# build deps
./build-boost.sh
./build-ffmpeg.sh
./build-osg.sh
./build-mygui.sh
./build-bullet.sh

# build openmw
generate_openmw_cfg () {
    tail -n +2 "$1" | sed -e 's!\(data\|resources\)=/usr/local/\(.*\)!\1=\2!g'
    echo "fallback-archive=Morrowind.bsa"
    echo "fallback-archive=Tribunal.bsa"
    echo "fallback-archive=Bloodmoon.bsa"
    echo "content=Morrowind.esm"
    echo "content=Tribunal.esm"
    echo "content=Bloodmoon.esm"
}

readonly pfx="$PWD/local"
readonly tmp="$PWD/tmp"
mkdir -p "$pfx"
mkdir -p "$tmp"

pushd "source"
mkdir -p build
cd build
export OSG_DIR="$pfx/lib64"
cmake \
    -DBUILD_LAUNCHER=OFF \
    -DBUILD_OPENCS=OFF \
    -DBUILD_WIZARD=OFF \
    -DBUILD_MYGUI_PLUGIN=OFF \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
DESTDIR="$tmp" make install
popd


# COPY PHASE
mkdir -p "$diststart/22320/dist/lib/"
cp -rfv "local/"{lib,lib64}/*.so* "$diststart/22320/dist/lib/"
cp -rfv "local/lib64/"osgPlugins-* "$diststart/22320/dist/lib/"
cp -rfv "$tmp/usr/local/"{bin,etc,share} "$diststart/22320/dist/"

cp "assets/openmw.sh" "$diststart/22320/dist/"

generate_openmw_cfg "$tmp/usr/local/etc/openmw/openmw.cfg" > "$diststart/22320/dist/openmw.cfg"
cp "$tmp/usr/local/etc/openmw/settings-default.cfg" "$diststart/22320/dist/"

# TODO: compile launcher, forcing Qt 5.x if possible
cp assets/openmw-launcher-wrapper "$diststart/22320/dist/"
