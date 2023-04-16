#!/bin/bash

# CLONE PHASE
git clone https://github.com/MyGUI/mygui mygui
pushd mygui
git checkout -f 81e5c67
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "mygui"
mkdir -p build
cd build
cmake \
	-DCMAKE_INSTALL_PREFIX="$pfx" \
	-DMYGUI_RENDERSYSTEM=1 \
	-DMYGUI_BUILD_DEMOS=OFF \
	-DMYGUI_BUILD_TOOLS=OFF \
	-DMYGUI_BUILD_PLUGINS=OFF \
	-DCMAKE_BUILD_TYPE=Release \
	..
make -j "$(nproc)"
make install
popd
