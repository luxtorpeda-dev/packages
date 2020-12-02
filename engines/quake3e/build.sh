#!/bin/bash

sudo apt-get -y install libxxf86dga-dev libxrandr-dev libxxf86vm-dev libasound-dev

# CLONE PHASE
git clone https://github.com/ec-/Quake3e.git source
pushd source
git checkout adc9dd4
popd

# BUILD PHASE
pushd "source"
make -j "$(nproc)"
popd

# COPY PHASE
COPYDIR="$diststart/common/dist/" make --directory="source" copyfiles
