#!/bin/bash

readonly tmp="$PWD/tmp"
mkdir -p "$pfx"

# CLONE PHASE
git clone https://github.com/OpenMW/openmw source
pushd source
git checkout -f bac679d
git submodule update --init --recursive
git am < ../patches/0001-Fix-compile-error.patch
popd

# BUILD PHASE
generate_openmw_cfg () {
    tail -n +2 "$1" | sed -e 's!\(data\|resources\)=/usr/local/\(.*\)!\1=\2!g'
    echo "fallback-archive=Morrowind.bsa"
    echo "fallback-archive=Tribunal.bsa"
    echo "fallback-archive=Bloodmoon.bsa"
    echo "content=Morrowind.esm"
    echo "content=Tribunal.esm"
    echo "content=Bloodmoon.esm"
}

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
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
DESTDIR="$tmp" make install
popd

# COPY PHASE
mkdir -p "$diststart/22320/dist/lib/"
cp -rfv "$pfx/"lib/*.so* "$diststart/22320/dist/lib/"
cp -rfv "$pfx/lib/"osgPlugins-* "$diststart/22320/dist/lib/"
cp -rfv "$tmp/usr/local/"{etc,share} "$diststart/22320/dist/"
cp -rfv "$tmp/usr/local/bin/"* "$diststart/22320/dist/"
cp "assets/openmw-launcher.sh" "$diststart/22320/dist/"
cp "source/files/settings-default.cfg" "$diststart/22320/dist/"
cp -rfv source/build/defaults.bin "$diststart/22320/dist/"
