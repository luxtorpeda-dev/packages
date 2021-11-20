#!/bin/bash

apt update
apt install -y mercurial

# CLONE PHASE
hg clone https://www.retrodev.com/repos/blastem source
pushd source
hg update 460e14497120
popd

git clone https://github.com/nigels-com/glew.git glew
pushd glew
git checkout -f 062067f
popd

# BUILD PHASE
pushd glew
# cd build
make install
popd

pushd source
mkdir build
cd build
# cmake -DCMAKE_INSTALL_PREFIX=/tmp ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build" "$diststart/34270/dist/"
cp -rfv "assets/*" "$diststart/34270/dist/"

