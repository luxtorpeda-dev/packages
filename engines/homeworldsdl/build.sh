#!/bin/bash

# CLONE PHASE
git clone https://gitlab.com/ThibaultLemaire/HomeworldSDL.git source
pushd source
git checkout 402e6c8d
popd

# BUILD PHASE
pushd "source"
cd Linux
./bootstrap
../configure
make
popd

pushd "source"
cd tools/biggie
./biggie-Linux-compile.sh
cd ../../HomeworldSDL_big
./convert_directory_to_big_file
popd

# COPY PHASE
cp -rfv "source/Linux/src/homeworld" "$diststart/244160/dist/"
cp -rfv "source/HomeworldSDL.big" "$diststart/244160/dist/"
cp -rfv assets/* "$diststart/244160/dist/"
