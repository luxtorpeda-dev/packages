#!/bin/bash

apt-get -y install bison flex

# CLONE PHASE
git clone https://github.com/ptitSeb/Serious-Engine.git source
pushd source
git checkout 253d2b9
popd

# PRE-COPY PHASE
mkdir -p "$diststart/41050/dist/lib/"
mkdir -p "$diststart/41060/dist/lib/"

# BUILD PHASE
pushd source/Sources
./build-linux64.sh
popd

# COPY PHASE
cp -rfv source/Sources/cmake-build/ssam "$diststart/41060/dist/"
cp -rfv source/Sources/cmake-build/Debug/* "$diststart/41060/dist/lib"

# BUILD PHASE
pushd source/Sources
./build-linux64.sh -DTFE=TRUE
popd

# COPY PHASE
cp -rfv source/Sources/cmake-build/ssam-tfe "$diststart/41050/dist/"
cp -rfv source/Sources/cmake-build/Debug/* "$diststart/41050/dist/lib"
