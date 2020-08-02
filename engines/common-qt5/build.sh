#!/bin/bash

# CLONE PHASE
git clone https://code.qt.io/qt/qt5.git source
pushd source
git checkout -f 5.12
git submodule update --init --recursive
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

sudo apt-get -y install flex gperf bison

# BUILD PHASE
mkdir -p qt5-build
pushd qt5-build
../source/configure -opensource -nomake examples -nomake tests -confirm-license -prefix "$pfx" -skip qtconnectivity -skip qtandroidextras -skip qtpurchasing -skip qtserialbus -skip qtserialport -skip qtcharts -skip qtcanvas3d -skip qt3d -skip qtwebview -skip qtvirtualkeyboard -skip qtwayland -skip qtcharts -skip qtsensors -skip qtdatavis3d -skip qtdocgallery -skip qtfeedback -skip qtlocation -skip qttools -skip qtwebglplugin -skip qttranslations
make -j $(nproc)
make install
popd

# COPY PHASE
cp -rfv "$pfx/lib" "$diststart/common/dist"
cp -rfv "$pfx/include" "$diststart/common/dist"
