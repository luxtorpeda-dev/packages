#!/bin/bash

# CLONE PHASE
wget https://downloads.sourceforge.net/project/p7zip/p7zip/16.02/p7zip_16.02_src_all.tar.bz2
tar -xvjf p7zip_16.02_src_all.tar.bz2

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "p7zip_16.02"
cp -rfv makefile.linux_amd64_asm makefile.machine
make all3
make install DEST_DIR="$pfx"
popd

# COPY PHASE
mkdir -p "$diststart/13250/dist/7z/"
cp -rfv "$pfx/usr/local/bin/"* "$diststart/13250/dist/7z/"
cp -rfv "$pfx/usr/local/lib/p7zip/"* "$diststart/13250/dist/7z/"
cp -rfv assets/* "$diststart/13250/dist/"
