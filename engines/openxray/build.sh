#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenXRay/xray-16 source
pushd source
git checkout -f 3d62bd5
git submodule update --init --recursive
git am < ../patches/0001-Changes-to-make-Linux-compile.patch
popd

git clone https://github.com/WinMerge/freeimage freeimage
pushd freeimage
git checkout -f fbc617c1
git submodule update --init --recursive
popd

git clone https://github.com/miquels/liblockfile liblockfile
pushd liblockfile
git checkout -f a3bb92f6
git submodule update --init --recursive
popd

git clone https://git.savannah.gnu.org/git/readline.git readline
pushd readline
git checkout -f d49a9082
git submodule update --init --recursive
popd

git clone https://github.com/wjakob/tbb tbb
pushd tbb
git checkout -f 20357d83
git submodule update --init --recursive
popd

git clone https://github.com/nigels-com/glew.git glew
pushd glew
git checkout -f 3a8eff7
git submodule update --init --recursive
popd

readonly pstart="$PWD"
readonly pfx="$PWD/local"
mkdir -p "$pfx"

apt-get install -y binutils-2.30
PATH="/usr/lib/binutils-2.30/bin:$PATH"

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

# build lockfile
pushd "liblockfile"
mkdir -p "$pfx/LockFile"
./configure --enable-shared --prefix="$pfx/LockFile"
make -j "$(nproc)"
make install
popd

# build crypto++
pushd "source/Externals/cryptopp"
mkdir -p "$pfx/Crypto++"
make clean
make dynamic -j "$(nproc)"
make install PREFIX="$pfx/Crypto++"
cp -rfv "$pfx/Crypto++/include/cryptopp"/*  "$pfx/Crypto++/include"
popd

# build lzo
pushd "source/Externals/lzo"
chmod +x configure
./configure --enable-shared --prefix="$pfx"
make -j "$(nproc)"
make install
popd

# build readline
pushd "readline"
./configure --enable-shared --prefix="$pfx"
make -j "$(nproc)"
make install
popd

# build tbb
pushd "tbb"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

# build glew
pushd glew
GLEW_DEST="$pfx" make -j "$(nproc)"
GLEW_DEST="$pfx" make install
popd

# build openxray
pushd "source"
mkdir -p bin
cd bin

cmake \
        -DFREEIMAGE_LIBRARY="$pfx/lib/libfreeimage-3.18.0.so" \
        -DFREEIMAGEPLUS_LIBRARY="$pfx/lib/libfreeimageplus-3.18.0.so" \
        -DLZO_ROOT_DIR="$pfx" \
        -DCMAKE_PREFIX_PATH="$pfx" \
        -DTBB_INSTALL_DIR="$pfx" \
        -DTBB_INCLUDE_DIRS="$pfx/include" \
        -DTBB_LIBRARY_DIRS="$pfx/lib" \
        -DFREEIMAGE_INCLUDE_PATH="$pfx/include" \
        -DGLEW_INCLUDE_DIRS="$pfx/include" \
        -DGLEW_LIBRARIES="$pstart/glew-2.1.0/lib" \
        -DGLEW_USE_STATIC_LIBS=ON \
        ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
