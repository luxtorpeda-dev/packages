#!/bin/bash

sudo apt-get install -y python-yaml bc

wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
sudo pip3 install setconf

# CLONE PHASE
git clone https://github.com/svaarala/duktape.git duktape
pushd duktape
git checkout -f 6001888
popd

# BUILD PHASE
pushd "duktape"
make dist -j "$(nproc)"
popd

pushd "duktape/dist"
mv Makefile.sharedlibrary Makefile
sed 's/-Wall -Wextra/$(CFLAGS)/g' -i Makefile
CFLAGS="$CFLAGS -D DUK_USE_FASTINT -w" make -j "$(nproc)"
setconf Makefile INSTALL_PREFIX="$pfx"
make install
popd
