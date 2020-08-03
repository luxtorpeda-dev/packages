#!/bin/bash

set -x
set -e

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# build mygui
#
pushd "mygui"
mkdir -p build
cd build
cmake \
	-DCMAKE_INSTALL_PREFIX="$pfx" \
	-DMYGUI_RENDERSYSTEM=1 \
	-DMYGUI_BUILD_DEMOS=OFF \
	-DMYGUI_BUILD_TOOLS=OFF \
	-DMYGUI_BUILD_PLUGINS=OFF \
	..
make -j "$(nproc)"
make install
popd
