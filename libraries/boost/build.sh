#!/bin/bash

# CLONE PHASE
git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f ccb2ab3
git submodule update --init --recursive
popd

# BUILD PHASE
export boostlocation="$PWD/boost"
pushd "boost"
./bootstrap.sh
./b2 headers
./b2 variant=release \
	--with-program_options \
	--with-filesystem \
	--with-system \
	--with-iostreams \
	--with-locale \
./b2 install --prefix="$pfx"
popd

cp -rfv "$pfx/lib/"* /usr/lib
