#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/OpenXRay/xray-16 source
pushd source
git checkout -f 1579d1f
git submodule update --init --recursive
git am < ../patches/0001-Changes-to-make-Linux-compile.patch
git am < ../patches/0001-library-linking-path-fixes.patch
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

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

git clone https://github.com/xiph/theora.git theora
pushd theora
git checkout -f 7ffd8b2
popd

git clone https://github.com/xiph/ogg.git ogg
pushd ogg
git checkout -f bada457
popd

git clone https://github.com/xiph/vorbis.git vorbis
pushd vorbis
git checkout -f 0657aee
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.8
popd

git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git libjpeg-turbo
pushd libjpeg-turbo
git checkout -f ae87a95
popd

git clone https://github.com/luvit/pcre.git pcre
pushd pcre
git checkout -f e2a236a
popd

wget https://github.com/nigels-com/glew/releases/download/glew-2.1.0/glew-2.1.0.zip
unzip glew-2.1.0.zip -d glew

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -w"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -w"

readonly pstart="$PWD"
readonly pfx="$PWD/local"
mkdir -p "$pfx"

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
pushd glew/glew-2.1.0
GLEW_DEST="$pfx" make -j "$(nproc)"
GLEW_DEST="$pfx" make install
make install
popd

pushd "openal"
rm -rf build
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "openal"
rm -rf build
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "ogg"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "vorbis"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "SDL"
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

pushd "pcre"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DPCRE_BUILD_TESTS=OFF \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    ..
make -j "$(nproc)"
make install
popd

pushd "theora"
./autogen.sh
./configure --enable-shared --prefix="$pfx"
make -j "$(nproc)"
make install
popd

cp -rfv /usr/local/lib/*ogg.so* "$pfx/lib"
cp -rfv /usr/local/lib/*openal.so* "$pfx/lib"
cp -rfv /usr/local/lib/*vorbis*.so* "$pfx/lib"

# build openxray
export SystemDrive="$pfx"
pushd "source"
mkdir -p bin
cd bin
cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DFREEIMAGE_LIBRARY="$pfx/lib/libfreeimage-3.18.0.so" \
        -DFREEIMAGEPLUS_LIBRARY="$pfx/lib/libfreeimageplus-3.18.0.so" \
        -DLZO_ROOT_DIR="$pfx" \
        -DCMAKE_PREFIX_PATH="$pfx" \
        -DCMAKE_INSTALL_PREFIX="$pfx" \
        -DCMAKE_INSTALL_LIBDIR="$pfx/lib" \
        -DTBB_INSTALL_DIR="$pfx" \
        -DTBB_INCLUDE_DIRS="$pfx/include" \
        -DFREEIMAGE_INCLUDE_PATH="$pfx/include" \
        -DGLEW_INCLUDE_DIRS="$pfx/include" \
        -DGLEW_LIBRARIES="$pstart/glew/glew-2.1.0/lib/libGLEW.so" \
        -DLOCKFILE_LIBRARIES="$pfx/LockFile/lib/liblockfile.so" \
        -DLOCKFILE_INCLUDE_DIR="$pfx/LockFile/include" \
        -DCRYPTO++_LIBRARIES="$pfx/Crypto++/lib/libcryptopp.so" \
        -DCRYPTO++_INCLUDE_DIR="$pfx/Crypto++/include" \
        -DPCRE_INCLUDE_DIR="$pfx/include" \
        -DPCRE_LIBRARY="$pfx/lib/libpcre.a" \
        -DOPENAL_LIBRARY="$pfx/lib/libopenal.so.1.20.1" \
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
cp -rfv "$pstart/tbb/build"/libtbb*.so* "$diststart/common/dist/lib"
cp -rfv "$pfx/LockFile/lib/"*.so* "$diststart/common/dist/lib"
cp -rfv glew/glew-2.1.0/lib/*.so* "$diststart/common/dist/lib"
cp assets/*.sh "$diststart/common/dist"
cp -rfv plus/res/gamedata/* "$diststart/common/dist/gamedata"
cp -rfv "$pfx/share/openxray"/* "$diststart/common/dist/"
