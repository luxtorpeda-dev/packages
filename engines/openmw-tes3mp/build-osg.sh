#!/bin/bash

set -x
set -e

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# build OpenSceneGraph
#
pushd "osg"
mkdir -p build
cd build
cmake \
	-D CMAKE_BUILD_TYPE=Release \
	-D CMAKE_INSTALL_PREFIX="$pfx" \
	-D OSG_USE_QT=OFF \
	-D BUILD_OSG_APPLICATIONS=OFF \
	-D BUILD_OSG_EXAMPLES=OFF \
	..
make -j "$(nproc)"
make install
popd
