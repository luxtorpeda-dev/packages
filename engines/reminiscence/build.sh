#!/bin/bash

# CLONE PHASE
wget http://cyxdown.free.fr/reminiscence/REminiscence-0.4.6.tar.bz2
tar xvf REminiscence-0.4.6.tar.bz2

git clone https://github.com/Konstanty/libmodplug.git
pushd libmodplug
git checkout -f d7ba5ef
popd

git clone https://gitlab.xiph.org/xiph/tremor.git
pushd tremor
git checkout -f 7c30a66346199f3f09017a09567c6c8a3a0eedc8
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "libmodplug"
mkdir -p build
cd build
cmake \
    ..
make -j "$(nproc)" install
popd

pushd "tremor"
./autogen.sh
make
make install
popd

# BUILD PHASE
pushd REminiscence-0.4.6
make
popd

# COPY PHASE
cp -rfv REminiscence-0.4.6/rs "$diststart/961620/dist/rs"
