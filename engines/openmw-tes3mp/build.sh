#!/bin/bash

# CLONE PHASE
git clone https://github.com/TES3MP/openmw-tes3mp.git source
pushd source
git checkout -f 2925364
git submodule update --init --recursive
popd

git clone https://github.com/TES3MP/CoreScripts server
pushd server
git checkout -f 46698c1
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f afb333b7
git submodule update --init --recursive
popd

git clone https://github.com/bulletphysics/bullet3 bullet3
pushd bullet3
git checkout -f 6e4707df
git submodule update --init --recursive
popd

git clone https://github.com/FFmpeg/FFmpeg ffmpeg
pushd ffmpeg
git checkout -f ba11e40
git submodule update --init --recursive
popd

git clone https://github.com/MyGUI/mygui mygui
pushd mygui
git checkout -f 8a05127d
git submodule update --init --recursive
popd

git clone --recursive https://github.com/OpenMW/osg osg
pushd osg
git checkout -f 8b07809fa674ecffe77338aaea2e223b3aadff0e
git submodule update --init --recursive
popd

git clone https://github.com/twogood/unshield.git
pushd unshield
git checkout -f c5d3560
popd

git clone https://github.com/TES3MP/CrabNet.git crabnet
pushd crabnet
git checkout -f 19e6619
popd

git clone https://github.com/LuaJIT/LuaJIT.git luajit
pushd luajit
git checkout -f 570e758
popd

git clone https://github.com/Koncord/CallFF.git callff
pushd callff
git checkout -f da94b59
popd

wget https://github.com/zdevito/terra/releases/download/release-2016-03-25/terra-Linux-x86_64-332a506.zip
unzip terra-Linux-x86_64-332a506.zip

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
pstart="$PWD"

pushd unshield
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd crabnet
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCRABNET_ENABLE_DLL=OFF \
    -DCRABNET_ENABLE_SAMPLES=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

pushd callff
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
popd

pushd luajit
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

export CXXFLAGS="-fpermissive"
export CFLAGS="-fpermissive"
export Terra_ROOT="$pstart/terra-Linux-x86_64-332a506"
export RAKNET_ROOT="$pfx"

pushd "source"
mkdir -p build
cd build
export OSG_DIR="$pfx/lib64"
cmake \
    -DBUILD_LAUNCHER=ON \
    -DDESIRED_QT_VERSION=5 \
    -DBUILD_OPENCS=OFF \
    -DBUILD_WIZARD=ON \
    -DBUILD_MYGUI_PLUGIN=OFF \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DRakNet_LIBRARY_DEBUG="$pfx/lib/libRakNetLibStatic.a" \
    -DLuaJit_INCLUDE_DIR="$pfx/usr/local/include/luajit-2.1/" \
    -DLuaJit_LIBRARY="$pfx/usr/local/lib/libluajit-5.1.a" \
    -DCMAKE_CXX_FLAGS="-fpermissive" \
    -DCallFF_INCLUDES="$pstart/callff/include" \
    -DCallFF_LIBRARY="$pstart/callff/build/src/libcallff.a" \
    ..
make -j "$(nproc)"
DESTDIR="$tmp" make install
popd

# COPY PHASE
mkdir -p "$diststart/22320/dist/lib/"
cp -rfv "local/"{lib,lib64}/*.so* "$diststart/22320/dist/lib/"
cp -rfv "local/lib64/"osgPlugins-* "$diststart/22320/dist/lib/"
cp -rfv "$tmp/usr/local/"{etc,share} "$diststart/22320/dist/"
cp -rfv "$tmp/usr/local/bin/"* "$diststart/22320/dist/"

cp "assets/tes3mp-launcher.sh" "$diststart/22320/dist/"
generate_openmw_cfg "$tmp/usr/local/etc/openmw/openmw.cfg" > "$diststart/22320/dist/openmw-template.cfg"
cp "$tmp/usr/local/etc/openmw/settings-default.cfg" "$diststart/22320/dist/"
cp "$tmp/usr/local/etc/openmw/tes3mp-client-default.cfg" "$diststart/22320/dist"
cp "$tmp/usr/local/etc/openmw/tes3mp-server-default.cfg" "$diststart/22320/dist"
cp -rfv server "$diststart/22320/dist"
cp -rfv source/tes3mp-credits.md "$diststart/22320/dist"
