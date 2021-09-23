#!/bin/bash

# CLONE PHASE
wget https://zlib.net/zlib-1.2.11.tar.gz
tar xvf zlib-1.2.11.tar.gz

# BUILD PHASE
pushd zlib-1.2.11
./configure --prefix="$pfx"
make
make install DESTDIR="$pfx"
make install
popd
