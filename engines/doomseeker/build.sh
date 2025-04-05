#!/bin/bash

# CLONE PHASE
git clone https://bitbucket.org/Doomseeker/doomseeker.git source
pushd source
git checkout -f "$COMMIT_TAG"
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

mkdir -p pfx
export pfx="$PWD/pfx"

# BUILD PHASE
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

cp -rfv source/build/*.so* "$diststart/common/dist/lib"
cp -rfv source/build/translations "$diststart/common/dist"
cp -rfv source/build/engines "$diststart/common/dist"
