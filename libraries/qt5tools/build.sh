#!/bin/bash

# CLONE PHASE
git clone https://code.qt.io/qt/qttools.git source
pushd source
git checkout -f v5.12.11
git submodule update --init --recursive
popd

# BUILD PHASE
mkdir -p qt5-build
pushd qt5-build
qmake ../source
make -j $(nproc)
make install
popd
