#!/bin/bash

apt-get -y install xutils-dev xcb-proto python3-xcbgen

# CLONE PHASE
wget https://xcb.freedesktop.org/dist/xcb-util-0.4.1.tar.xz
tar xvf xcb-util-0.4.1.tar.xz

git clone https://github.com/xkbcommon/libxkbcommon.git
pushd libxkbcommon
git checkout -f cecaa01
popd

wget https://xorg.freedesktop.org/archive/individual/lib/xcb-util-wm-0.4.2.tar.xz
tar xvf xcb-util-wm-0.4.2.tar.xz

wget https://xorg.freedesktop.org/archive/individual/lib/xcb-util-image-0.4.1.tar.xz
tar xvf xcb-util-image-0.4.1.tar.xz

wget https://xorg.freedesktop.org/archive/individual/lib/xcb-util-keysyms-0.4.1.tar.xz
tar xvf xcb-util-keysyms-0.4.1.tar.xz

wget https://xorg.freedesktop.org/archive/individual/lib/xcb-util-renderutil-0.3.10.tar.xz
tar xvf xcb-util-renderutil-0.3.10.tar.xz

git clone https://gitlab.freedesktop.org/xorg/lib/libxcb.git
pushd libxcb
git checkout libxcb-1.14
popd

# BUILD PHASE
pushd xcb-util-0.4.1
./configure --disable-static
make
make DESTDIR="$pfx" install
make install
popd

pushd libxkbcommon
meson setup build -Denable-docs=false
meson install -C build --destdir "$pfx"
meson install -C build
popd

pushd xcb-util-wm-0.4.2
./configure --disable-static
make
make DESTDIR="$pfx" install
make install
popd

pushd xcb-util-image-0.4.1
./configure --disable-static
make
make DESTDIR="$pfx" install
make install
popd

pushd xcb-util-keysyms-0.4.1
./configure --disable-static
make
make DESTDIR="$pfx" install
make install
popd

pushd xcb-util-renderutil-0.3.10
./configure --disable-static
make
make DESTDIR="$pfx" install
make install
popd

pushd libxcb
./autogen.sh
make
make DESTDIR="$pfx" install
make install
popd
