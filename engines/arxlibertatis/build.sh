#!/bin/bash

# CLONE PHASE
git clone https://github.com/arx/ArxLibertatis source
pushd source
git checkout "$COMMIT_TAG"
popd

git clone https://github.com/arx/ArxLibertatisData.git data
pushd data
git checkout -f d92cc85
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build || exit 1
ln -s ../../data arx-libertatis-data
cmake \
    -DCMAKE_INSTALL_PREFIX=../../tmp \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv tmp/bin/* "$diststart/common/dist/"
cp -rfv tmp/lib/* "$diststart/common/dist/"
cp -rfv tmp/share/games/arx/* "$diststart/common/dist/"

mv "$diststart/common/dist/arx" "$diststart/common/dist/arx-bin"
cp -rfv assets/arx-launcher.sh "$diststart/common/dist/arx"
