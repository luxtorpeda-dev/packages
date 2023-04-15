#!/bin/bash

# CLONE PHASE
git clone https://github.com/ptitSeb/freespace2.git source
pushd source
git checkout -f 500ee24
git am < ../patches/0001-narrowing-fix.patch
popd

wget https://downloads.sourceforge.net/project/p7zip/p7zip/16.02/p7zip_16.02_src_all.tar.bz2
tar -xvjf p7zip_16.02_src_all.tar.bz2

export CFLAGS="$CFLAGS -Wno-narrowing -Wno-error=narrowing"
export CXXFLAGS="$CXXFLAGS -Wno-narrowing -Wno-error=narrowing"
export CPPFLAGS="$CPPFLAGS -Wno-narrowing -Wno-error=narrowing"

# BUILD PHASE
pushd "source"
make -j "$(nproc)" FS1=true DEBUG=true PANDORA=false
popd

pushd "p7zip_16.02"
cp -rfv makefile.linux_amd64_asm makefile.machine
make all3
make install DEST_DIR="$pfx"
popd

# COPY PHASE
cp -rfv "source/freespace" "$diststart/273600/dist/freespace"
cp -rfv "assets/run-freespace.sh" "$diststart/273600/dist/"
cp -rfv "assets/run-fsport.sh" "$diststart/273600/dist/"
mkdir -p "$diststart/273600/dist/7z/"
cp -rfv "$pfx/usr/local/bin/"* "$diststart/273600/dist/7z/"
cp -rfv "$pfx/usr/local/lib/p7zip/"* "$diststart/273600/dist/7z/"
