#!/bin/bash

# CLONE PHASE
git clone https://github.com/coelckers/Raze.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build"/{raze,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv "assets/"* "$diststart/common/dist/"
ln -rsf "$diststart/common/dist/lib/libfluidsynth.so.3" "$diststart/common/dist/lib/libfluidsynth.so.2"
