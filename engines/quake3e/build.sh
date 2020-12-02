#!/bin/bash

sudo apt-get -y install libxxf86dga-dev libxrandr-dev libxxf86vm-dev libasound-dev

# CLONE PHASE
git clone https://github.com/ec-/Quake3e.git source
pushd source
git checkout adc9dd4
popd

# BUILD PHASE
pushd "source"
make ARCH=x64_64 -j "$(nproc)"
make install DESTDIR="$diststart/common/dist/"
popd
