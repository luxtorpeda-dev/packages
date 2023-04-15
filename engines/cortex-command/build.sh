#!/bin/bash

# CLONE PHASE
git clone https://github.com/cortex-command-community/Cortex-Command-Community-Project-Source.git source
pushd source
git checkout -f 7e32a88
popd

git clone https://github.com/cortex-command-community/Cortex-Command-Community-Project-Data.git data
pushd data
git checkout -f eb306b4
popd

# BUILD PHASE
pushd source
BOOST_ROOT="$pfx" meson build
ninja -C build
popd

# COPY PHASE
cp -rfv data/* "$diststart/209670/dist/"
cp -rfv assets/* "$diststart/209670/dist"
cp source/build/CortexCommand.x86_64 "$diststart/209670/dist"
cp -rfv source/external/lib/linux/x86_64/libfmod.so "$diststart/209670/dist/lib/"
cp -rfv source/external/lib/linux/x86_64/libfmod.so.13 "$diststart/209670/dist/lib/"
cp -rfv source/external/lib/linux/x86_64/libfmod.so.13.13 "$diststart/209670/dist/lib/"
