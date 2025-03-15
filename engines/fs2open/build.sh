#!/bin/bash

# CLONE PHASE
git clone https://github.com/scp-fs2open/fs2open.github.com source
pushd source
git checkout -f "$COMMIT_TAG"
git submodule update --init --recursive
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
DESTDIR="$tmp" make install
popd

# COPY PHASE
cp -rfv "source/build/bin/fs2_open_*_x64" "$diststart/273620/dist/fs2_open_x64"
cp -rfv "assets/run-freespace2.sh" "$diststart/273620/dist/run-freespace2.sh"
