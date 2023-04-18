#!/bin/bash

apt-get -y install libreadline-dev

# CLONE PHASE
wget https://www.lua.org/ftp/lua-5.4.4.tar.gz
tar xvf lua-5.4.4.tar.gz
mv lua-5.4.4 lua
pushd lua
patch -p1 -i ../patches/liblua.so.patch
sed "s/%VER%/5/g;s/%REL%/5.4.4/g" ../lua.pc > lua.pc
popd

# BUILD PHASE
pushd lua
make -j "$(nproc)"
DESTDIR="$pfx" make install
make install
popd

cp -rfv /usr/local/lib/liblua.a /usr/lib/
ln -sf lua54.pc /usr/lib/pkgconfig/lua.pc
ln -sf lua54.pc /usr/lib/pkgconfig/lua5.4.pc
ln -sf lua54.pc /usr/lib/pkgconfig/lua-5.4.pc
