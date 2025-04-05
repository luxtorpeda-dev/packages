#!/bin/bash

# CLONE PHASE
git clone https://bitbucket.org/Doomseeker/doomseeker.git source
pushd source
git checkout -f "$COMMIT_TAG"
popd

# Define version and URL for qt5-multimedia
QT5MULTI_VERSION="5.15.16"
QT5MULTI_ARCHIVE="qtmultimedia-everywhere-opensource-src-${QT5MULTI_VERSION}.tar.xz"
QT5MULTI_URL="https://download.qt.io/official_releases/qt/5.15/${QT5MULTI_VERSION}/submodules/${QT5MULTI_ARCHIVE}"
QT5MULTI_SRC_DIR="qt5-multimedia-src"

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

mkdir -p pfx
export pfx="$PWD/pfx"

# BUILD PHASE
echo "Downloading qt5-multimedia ${QT5MULTI_VERSION}..."
wget "${QT5MULTI_URL}" -O "${QT5MULTI_ARCHIVE}"

echo "Extracting qt5-multimedia source..."
rm -rf "${QT5MULTI_SRC_DIR}"
mkdir "${QT5MULTI_SRC_DIR}"
tar -xf "${QT5MULTI_ARCHIVE}" -C "${QT5MULTI_SRC_DIR}" --strip-components=1

echo "Building qt5-multimedia..."
pushd "${QT5MULTI_SRC_DIR}"
mkdir -p build && cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    -DQT5_DIR="/usr/lib/x86_64-linux-gnu/cmake/Qt5" \
    -DQT_QMAKE_EXECUTABLE="/usr/bin/qmake" \
    ..
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv source/build/doomseeker "$diststart/common/dist"
cp -rfv "assets"/* "$diststart/common/dist"
cp -rfv "$pfx/lib/"*.so* "$diststart/common/dist/lib"
cp -rfv source/build/*.so* "$diststart/common/dist/lib"
cp -rfv source/build/translations "$diststart/common/dist"
cp -rfv source/build/engines "$diststart/common/dist"
