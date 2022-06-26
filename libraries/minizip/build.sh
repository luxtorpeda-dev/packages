#!/bin/bash

# CLONE PHASE
wget https://zlib.net/zlib-1.2.12.tar.gz
tar xvf zlib-1.2.12.tar.gz

# BUILD PHASE
pushd zlib-1.2.12
grep -A 24 '^  Copyright' zlib.h > LICENSE
cd contrib/minizip
mkdir -p build
cp Makefile Makefile.orig
cp ../README.contrib readme.txt
autoreconf --install
./configure --prefix="$pfx" --enable-static=no
make
make install DESTDIR="$pfx"
make install
popd
