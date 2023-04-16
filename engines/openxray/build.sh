#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/OpenXRay/xray-16 source
pushd source
git checkout -f bd5e903
git submodule update --init --recursive
popd

git clone https://github.com/OpenXRay/Plus.git plus
pushd plus
git checkout -f deaa827
popd

git clone https://github.com/WinMerge/freeimage freeimage
pushd freeimage
git checkout -f fbc617c1
git submodule update --init --recursive
popd

git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git libjpeg-turbo
pushd libjpeg-turbo
git checkout -f ae87a95
popd

# BUILD PHASE
# build freeimage
pushd "freeimage"
make -j "$(nproc)"
make -f Makefile.fip -j "$(nproc)"
mkdir -p "$pfx/include"
mkdir -p "$pfx/lib"
cp -rfv "Dist/libfreeimage-3.18.0.so" "$pfx/lib"
cp -rfv "Dist/FreeImage.h" "$pfx/include"
cp -rfv "Dist/libfreeimageplus-3.18.0.so" "$pfx/lib"
cp -rfv "Dist/FreeImagePlus.h" "$pfx/include"
popd

# build crypto++
pushd "source/Externals/cryptopp"
mkdir -p "$pfx/Crypto++"
make clean
make dynamic -j "$(nproc)"
make install PREFIX="$pfx/Crypto++"
cp -rfv "$pfx/Crypto++/include/cryptopp"/*  "$pfx/Crypto++/include"
popd
cp -rfv "$pfx/Crypto++/include/"* "/usr/include"
cp -rfv "$pfx/Crypto++/lib/"* "/usr/lib"

# build lzo
pushd "source/Externals/lzo"
chmod +x configure
./configure --enable-shared --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd "libjpeg-turbo"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/include/"* "/usr/include"
cp -rfv "$pfx/lib/"* "/usr/lib"

# build openxray
export SystemDrive="$pfx"
pushd "source"
mkdir -p bin
cd bin
cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DFREEIMAGE_LIBRARY="$pfx/lib/libfreeimage-3.18.0.so" \
        -DFREEIMAGEPLUS_LIBRARY="$pfx/lib/libfreeimageplus-3.18.0.so" \
        -DCMAKE_PREFIX_PATH="$pfx" \
        -DCMAKE_INSTALL_PREFIX="$pfx" \
        -DCMAKE_INSTALL_LIBDIR="$pfx/lib" \
        -DFREEIMAGE_INCLUDE_PATH="$pfx/include" \
        -DCRYPTO++_LIBRARIES="$pfx/Crypto++/lib/libcryptopp.so" \
        -DCRYPTO++_INCLUDE_DIR="$pfx/Crypto++/include" \
        -DLOCKFILE_LIBRARIES="$pfx/LockFile/lib/liblockfile.so" \
        -DLOCKFILE_INCLUDE_DIR="$pfx/LockFile/include" \
        ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
mkdir -p "$diststart/common/dist/gamedata"
cp -rfv "$pfx/bin/xr_3da" "$diststart/common/dist"
cp -rfv "$pfx/lib"/*.so* "$diststart/common/dist/lib"
cp -rfv "$pfx/Crypto++/lib"/*.so* "$diststart/common/dist/lib"

cp assets/*.sh "$diststart/common/dist"
cp -rfv plus/res/gamedata/* "$diststart/common/dist/gamedata"
cp -rfv "$pfx/share/openxray"/* "$diststart/common/dist/"
