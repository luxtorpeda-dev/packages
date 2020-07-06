#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/dxx-rebirth/dxx-rebirth.git source
pushd source
git checkout 0.60.0-beta2
popd

hg clone https://hg.icculus.org/icculus/physfs
pushd physfs
hg checkout release-3.0.2
popd

# BUILD PHASE
pushd physfs
mkdir build
cd build
cmake ..
make -j "$(nproc)"
make install
popd

pushd source
scons
popd

# COPY PHASE
mkdir -p "$diststart/273570/dist/lib"
mkdir -p "$diststart/273580/dist/lib"
cp -rfv physfs/build/libphysfs.so* "$diststart/273570/dist/lib"
cp -rfv physfs/build/libphysfs.so* "$diststart/273580/dist/lib"
cp -rfv source/d1x-rebirth/d1x-rebirth "$diststart/273570/dist/"
cp -rfv source/d2x-rebirth/d2x-rebirth "$diststart/273580/dist/"
