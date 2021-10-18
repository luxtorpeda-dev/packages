#!/bin/bash

# CLONE PHASE
git clone https://github.com/ptitSeb/freespace2.git source
pushd source
git checkout -f 500ee24
popd

# BUILD PHASE
pushd "source"
make -j "$(nproc)" FS1=true DEBUG=true PANDORA=false
popd

# COPY PHASE
cp -rfv "source/freespace" "$diststart/273600/dist/freespace"
cp -rfv "assets/run-freespace.sh" "$diststart/273600/dist/"
