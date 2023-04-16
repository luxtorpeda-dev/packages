#!/bin/bash

# CLONE PHASE
git clone https://bitbucket.org/Doomseeker/doomseeker.git source
pushd source
git checkout -f 9fab457
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5" \
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

cp -rfv source/build/*.so* "$diststart/common/dist/lib"
cp -rfv source/build/translations "$diststart/common/dist"
cp -rfv source/build/engines "$diststart/common/dist"
