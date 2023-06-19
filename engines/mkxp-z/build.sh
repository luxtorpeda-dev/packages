#!/bin/bash

apt-get update
apt-get -y install groff

# CLONE PHASE
git clone https://github.com/freedesktop/uchardet.git

git clone https://github.com/roboticslibrary/libiconv.git
pushd libiconv
git checkout -f 2582e7b
./gitsub.sh pull
./autogen.sh
popd

git clone https://github.com/mkxp-z/mkxp-z.git source
pushd source
git checkout -f b594640
popd

# BUILD PHASE
pushd uchardet
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

pushd libiconv
./configure --prefix="$pfx"
make -j "$(nproc)"
make -j "$(nproc)" install
popd

pushd source
meson build
cd build && ninja
meson configure --bindir=. --prefix=$PWD/local
ninja install
popd

# COPY PHASE
cp -rfv "source/build/local/"* "$diststart/common/dist"
