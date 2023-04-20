#!/bin/bash

# CLONE PHASE
git clone https://github.com/LuaJIT/LuaJIT.git luajit
pushd luajit
git checkout -f 421c4c7
popd

# BUILD PHASE
pushd luajit
make BUILDMODE=dynamic -j "$(nproc)"
DESTDIR="$pfx" make BUILDMODE=dynamic install
make BUILDMODE=dynamic install
popd
