#!/bin/bash

sudo apt-get install -y libnss3-dev

# CLONE PHASE
git clone https://github.com/qt/qt5.git source
pushd source
git checkout -f v5.15.7-lts-lgpl
git submodule update --init --recursive
popd

# BUILD PHASE
mkdir -p qt5-build
pushd qt5-build
../source/configure -opensource -nomake examples -nomake tests -confirm-license -prefix "$pfx/qt5" -skip qtconnectivity -skip qtandroidextras -skip qtpurchasing -skip qtserialbus -skip qtserialport -skip qtcharts -skip qtcanvas3d -skip qt3d -skip qtwebview -skip qtvirtualkeyboard -skip qtcharts -skip qtsensors -skip qtdatavis3d -skip qtdocgallery -skip qtfeedback -skip qtlocation -skip qttools -skip qttranslations -skip qtwebsockets -skip qtspeech
make -j $(nproc)
make install
popd

export PATH="$pfx/qt5/bin:$PATH"
