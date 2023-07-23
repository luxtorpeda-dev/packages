#!/bin/bash

# ===================== Xcb deps phase     =====================

export pfx="$PWD/local"

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

# ===================== Xcb deps phase end =====================

# CLONE PHASE
git clone https://github.com/OpenMW/openmw source
pushd source
git checkout -f 3b669c2
popd

git clone https://github.com/zesterer/openmw-shaders.git openmw-shaders
pushd openmw-shaders
git checkout 3428a4f
popd

# COPY PHASE
mkdir -p "$diststart/22320/dist/lib"
cp assets/* "$diststart/22320/dist/"
mkdir -p "$diststart/22320/dist/openmw-shaders"
cp -rfv openmw-shaders/shaders/* "$diststart/22320/dist/openmw-shaders"
cp -rfv "$pfx/usr/local/lib/*.so*" "$diststart/22320/dist/lib"
