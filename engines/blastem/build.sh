#!/bin/bash

apt update
apt install -y mercurial

# CLONE PHASE
hg clone https://www.retrodev.com/repos/blastem source
pushd source
hg update 460e14497120
popd

# git clone https://github.com/nigels-com/glew.git glew
# pushd glew
# git checkout -f 062067f
# popd

wget https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip
unzip glew-2.2.0.zip


# BUILD PHASE
pushd glew-2.2.0
# cd build
make install
popd

pushd source
# cmake -DCMAKE_INSTALL_PREFIX=/tmp ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$dirstart/34270/dist/emu/"
cp -rfv "source" "$diststart/34270/dist/emu"
cp -rfv "assets/run-blastem.sh" "$diststart/34270/dist/"

