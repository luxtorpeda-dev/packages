#!/bin/bash

# CLONE PHASE
git clone https://github.com/svaarala/duktape.git duktape
pushd duktape
git checkout -f 03d4d72
popd

# BUILD PHASE
pushd "duktape"
make dist -j "$(nproc)"
popd

pushd "duktape/dist"
sed 's/-Wall -Wextra/$(CFLAGS)/g' -i Makefile
CFLAGS="$CFLAGS -D DUK_USE_FASTINT -w" make -j "$(nproc)"
setconf Makefile INSTALL_PREFIX="$pfx"
make install
popd
