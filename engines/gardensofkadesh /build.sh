#!/bin/bash

# CLONE PHASE
git clone https://github.com/GardensOfKadesh/Homeworld.git source
pushd source
git checkout 4e3f75d
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
cp -rfv "source/wasm/plug.tga" "$diststart/244160/dist/"
cp -rfv "source/HomeworldSDL.big" "$diststart/244160/dist/"
cp -rfv assets/* "$diststart/244160/dist/"
