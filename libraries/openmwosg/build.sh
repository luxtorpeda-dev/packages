#!/bin/bash

# CLONE PHASE
git clone --recursive https://github.com/OpenMW/osg osg
pushd osg
git checkout -f dd803bc
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "osg"
mkdir -p build
cd build
cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX="$pfx" \
	-DOSG_USE_QT=OFF \
	-DBUILD_OSG_APPLICATIONS=OFF \
	-DBUILD_OSG_EXAMPLES=OFF \
	..
make -j "$(nproc)"
make install
popd
