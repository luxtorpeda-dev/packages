#!/bin/bash

sudo apt-get install -y python-yaml bc
curl -s https://setconf.roboticoverlords.org/setconf-0.7.7.tar.xz | tar JxC /tmp
sudo install -Dm755 /tmp/setconf-0.7.7/setconf.py /usr/bin/setconf
sudo install -Dm644 /tmp/setconf-0.7.7/setconf.1.gz /usr/share/man/man1/setconf.1.gz

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
