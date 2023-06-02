#!/bin/bash

# CLONE PHASE
git clone --recursive https://github.com/OpenMW/osg osg
pushd osg
git checkout -f 76e061739610bc9a3420a59e7c9395e742ce2f97
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "osg"
mkdir -p build
cd build
cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX="$pfx" \
	-DBUILD_OSG_APPLICATIONS=OFF \
	-DBUILD_OSG_EXAMPLES=OFF \
	-DBUILD_OSG_PLUGINS_BY_DEFAULT=0 \
	-DBUILD_OSG_PLUGIN_OSG=1 \
	-DBUILD_OSG_PLUGIN_DDS=1 \
	-DBUILD_OSG_PLUGIN_DAE=1 \
	-DBUILD_OSG_PLUGIN_TGA=1 \
	-DBUILD_OSG_PLUGIN_BMP=1 \
	-DBUILD_OSG_PLUGIN_JPEG=1 \
	-DBUILD_OSG_PLUGIN_PNG=1 \
	-DBUILD_OSG_DEPRECATED_SERIALIZERS=0 \
	..
make -j "$(nproc)"
make install
popd
