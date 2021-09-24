#!/bin/bash

# CLONE PHASE
wget https://www.gnu.org/software/xorriso/xorriso-1.5.2.tar.gz
tar xvf xorriso-1.5.2.tar.gz

# BUILD PHASE
pushd xorriso-1.5.2
./configure
make
popd
