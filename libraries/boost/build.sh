#!/bin/bash

# CLONE PHASE
git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f 9d3f9bc
git submodule update --init --recursive
popd

# BUILD PHASE
export boostlocation="$PWD/boost"
pushd "boost"
./bootstrap.sh
./b2 headers
./b2 \
	--with-program_options \
	--with-filesystem \
	--with-system \
	--with-iostreams \
	--with-locale \
./b2 install --prefix="$pfx"
popd
