#!/bin/bash

# CLONE PHASE

# git clone https://github.com/nigels-com/glew.git glew
# pushd glew
# git checkout -f 062067f
# popd

# The git clone currently gives an error during make, using zip until fixed

wget https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip
unzip glew-2.2.0.zip

# BUILD PHASE
pushd glew-2.2.0
make -j "$(nproc)"
make install
popd
