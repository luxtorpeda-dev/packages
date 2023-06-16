#!/bin/bash

apt-get -y install texinfo

# CLONE PHASE
git clone https://github.com/bminor/binutils-gdb.git binutils-gdb
pushd binutils-gdb
git checkout -f fb0894b
popd

# BUILD PHASE
tmpprefix="$PWD/binutils-prefix"
mkdir -p "$tmpprefix"
pushd "binutils-gdb"
./configure --prefix="$tmpprefix" --disable-gdb --disable-gdbserver --disable-libdecnumber --disable-readline --disable-sim --disable-werror  --disable-elfcpp --disable-gold --disable-gprof --disable-ld --disable-libbacktrace --disable-libctf --disable-libdecnumber --disable-readline --disable-texinfo --disable-zlib
make -j "$(nproc)"
make install
popd
