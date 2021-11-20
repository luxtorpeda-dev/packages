#!/bin/bash

apt install mercurial -y

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
# mkdir build
# cd build
make install
popd

pushd source
# mkdir build
# cd build
# cmake -DCMAKE_INSTALL_PREFIX=/tmp ..
# make -j "$(nproc)"
make
popd

# COPY PHASE
# cp -rfv /tmp/* "$diststart/34270/dist/"
