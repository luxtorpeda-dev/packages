#!/bin/bash

# CLONE PHASE
wget https://invisible-island.net/datafiles/release/byacc.tar.gz
tar xvf byacc.tar.gz

# BUILD PHASE
pushd "byacc-20210808"
./configure --enable-btyacc --program-transform=s,^,b,
make -j "$(nproc)"
make install
popd
