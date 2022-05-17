#!/bin/bash

# CLONE PHASE
git clone https://github.com/ptitSeb/Serious-Engine.git source
pushd source
git checkout ab0aa4f
popd

# PRE-COPY PHASE
mkdir -p "$diststart/41050/dist/Bin/"
mkdir -p "$diststart/41060/dist/Bin/"
cp -rfv source/SE1_10.gro "$diststart/41050/dist"
cp -rfv source/SE1_10.gro "$diststart/41060/dist"

# BUILD PHASE
pushd source/Sources
./build-linux64.sh
popd

# COPY PHASE
cp -rfv source/Sources/cmake-build/ssam "$diststart/41060/dist/Bin/ssam"
cp -rfv source/Sources/cmake-build/Debug/* "$diststart/41060/dist/Bin"

# BUILD PHASE
pushd source/Sources
./build-linux64.sh -DTFE=TRUE
popd

# COPY PHASE
cp -rfv source/Sources/cmake-build/ssam-tfe "$diststart/41050/dist/Bin/ssam-tfe"
cp -rfv source/Sources/cmake-build/Debug/* "$diststart/41050/dist/Bin"
