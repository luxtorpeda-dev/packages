#!/bin/bash

# CLONE PHASE
git clone https://github.com/ptitSeb/freespace2.git source
pushd source
git checkout -f 500ee24
git am < ../patches/0001-narrowing-fix.patch
popd

git clone https://github.com/p7zip-project/p7zip.git
pushd p7zip
git checkout -f a45b883
popd

# BUILD PHASE
pushd "source"
make -j "$(nproc)" FS1=true DEBUG=true PANDORA=false
popd

pushd "p7zip"
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
