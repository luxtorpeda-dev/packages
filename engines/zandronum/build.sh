#!/bin/bash

# CLONE PHASE
git clone https://github.com/TorrSamaho/zandronum.git source
pushd source
git checkout "$COMMIT_HASH"
popd

wget https://zandronum.com/essentials/fmod/fmodapi42416linux64.tar.gz
tar -xvf fmodapi42416linux64.tar.gz

# COPY PHASE
cp -rfv assets/* "$diststart/common/dist/"
