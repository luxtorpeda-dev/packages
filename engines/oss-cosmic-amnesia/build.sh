#!/bin/bash

# CLONE PHASE
git clone https://github.com/OSS-Cosmic/AmnesiaTheDarkDescent.git source
pushd source
git checkout -f 6b387d7

git clone https://github.com/OSS-Cosmic/The-Forge.git external/The-Forge
pushd external/The-Forge
git checkout -f 80ddbfe
popd

git clone https://github.com/microsoft/vcpkg.git vcpkg
pushd vcpkg
git checkout -f 4a600e9
popd
popd

export CXXFLAGS="-I"$VCPKG_INSTALLED_PATH"/include"
export CFLAGS="-I"$VCPKG_INSTALLED_PATH"/include"
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# BUILD PHASE
pushd "source"
ls -l vcpkg
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DAMNESIA_GAME_DIRECTORY:STRING='' \
    -DIL_LIBRARIES="$VCPKG_INSTALLED_PATH/lib" \
    -DILU_LIBRARIES="$VCPKG_INSTALLED_PATH/lib" \
    -DIL_INCLUDE_DIR="$VCPKG_INSTALLED_PATH/include" \
    -G Ninja \
    ..
ninja
popd

# COPY PHASE
cp -rfv "source/build/"* "$diststart/57300/dist"
cp -rfv "assets/"* "$diststart/57300/dist"

mkdir -p licenses
licensepath="$PWD/licenses"
pushd ./source/vcpkg_installed/x64-linux/share
for d in */ ; do
    directory=${d::-1}
    echo "$directory"
    if [ -f "$directory/copyright" ]; then
        cp -rfv "$d/copyright" "$licensepath/$directory.copyright"
    fi
done
popd
