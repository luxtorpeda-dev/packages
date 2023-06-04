#!/bin/bash

# ===================== Xcb deps phase     =====================

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
git clone https://github.com/qt/qt5.git source
pushd source
git checkout -f v5.15.7-lts-lgpl
git submodule update --init --recursive
popd

# BUILD PHASE
mkdir -p qt5-build
pushd qt5-build
../source/configure -opensource -nomake examples -nomake tests -confirm-license -prefix "$pfx/qt5" -skip qtconnectivity -skip qtandroidextras -skip qtpurchasing -skip qtserialbus -skip qtserialport -skip qtcharts -skip qtcanvas3d -skip qt3d -skip qtwebview -skip qtvirtualkeyboard -skip qtcharts -skip qtsensors -skip qtdatavis3d -skip qtdocgallery -skip qtfeedback -skip qtlocation -skip qttools -skip qttranslations -skip qtwebsockets -skip qtspeech -qt-pcre -bundled-xcb-xinput
make -j $(nproc)
make install
popd

export PATH="$pfx/qt5/bin:$PATH"

rm -rf source
rm -rf qt5-build
