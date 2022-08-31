#!/bin/bash

apt-get -y install nasm

# CLONE PHASE
git clone https://bitbucket.org/CPMADevs/cnq3.git source
pushd source
git checkout 1b74aed
popd


# BUILD PHASE
pushd "source"
make config=release client
popd

# COPY PHASE
cp -rfv source/makefiles/linux_gmake/cnq3-x64 "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
