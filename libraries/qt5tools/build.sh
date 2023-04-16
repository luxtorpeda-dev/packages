#!/bin/bash

# CLONE PHASE
git clone https://github.com/qt/qttools.git source
pushd source
git checkout -f 1e7d509
git submodule update --init --recursive
popd

# BUILD PHASE
mkdir -p qt5-build
pushd qt5-build
qmake ../source
make -j $(nproc)
make install
popd
