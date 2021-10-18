#!/bin/bash

apt-get update
apt-get -y install subversion

# CLONE PHASE
svn co svn://svn.icculus.org/freespace2/trunk freespace2

# BUILD PHASE
pushd "freespace2"
make -j "$(nproc)" FS1=true DEBUG=true
popd

# COPY PHASE
cp -rfv "freespace2/freespace" "$diststart/273600/dist/freespace2"
cp -rfv "assets/run-freespace.sh" "$diststart/273600/dist/"
