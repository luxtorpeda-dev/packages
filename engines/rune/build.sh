#!/bin/bash

# CLONE PHASE
git clone https://github.com/MrAlert/sdlcl sdlcl
pushd sdlcl
git checkout -f 85ca5537
git am < ../patches/0001-Force-32-bit.patch
popd

wget https://downloads.sourceforge.net/project/p7zip/p7zip/16.02/p7zip_16.02_src_all.tar.bz2
tar -xvjf p7zip_16.02_src_all.tar.bz2

# BUILD PHASE
pushd "sdlcl"
make -j "$(nproc)"
popd

pushd "p7zip_16.02"
cp -rfv makefile.linux_amd64_asm makefile.machine
make all3
make install DEST_DIR="$diststart/210950/dist/"
popd

# COPY PHASE
cp -rfv assets/* "$diststart/210950/dist/"
cp -rfv "sdlcl/libSDL-1.2.so.0" "$diststart/3970/dist/"
