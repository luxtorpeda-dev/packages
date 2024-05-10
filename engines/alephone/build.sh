#!/bin/bash

sudo apt-get -y install autoconf-archive

export CXXFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export CFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/Aleph-One-Marathon/alephone.git source
pushd source
git checkout -f "$COMMIT_TAG"
git submodule update --init --recursive
popd

# BUILD PHASE
pushd source
autoreconf -i
./configure --with-boost-libdir="$VCPKG_INSTALLED_PATH/lib"
make
popd

# COPY PHASE
cp -rfv assets/* "$diststart/2398450/dist/"
cp -rfv source/Source_Files/alpehone "$diststart/2398450/dist/"
