#!/bin/bash

# CLONE PHASE
git clone https://code.qt.io/qt/qt5.git source
pushd source
git checkout -f 5.12
git submodule update --init --recursive
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
mkdir -p qt5-build
pushd qt5-build
../source/configure -opensource -nomake examples -nomake tests -confirm-license -prefix="$pfx" -qt-xcb -skip qtconnectivity -skip qtandroidextras -skip qtpurchasing -skip qtserialbus -skip qtserialport
make -j $(nproc)
make install
popd

# COPY PHASE
