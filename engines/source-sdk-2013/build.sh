#!/bin/bash

# CLONE PHASE
git clone https://github.com/ValveSoftware/source-sdk-2013 source
pushd source
git checkout -f 0d8dcee
popd

git clone https://github.com/ValvePython/vpk.git
pushd vpk
git checkout -f 3ff641e
rm -rf .git
popd

# COPY PHASE
cp -rfv assets/entropy-zero/* "$diststart/714070/dist/"

cp -rfv assets/metastasis/* "$diststart/235780/dist/"

cp -rfv assets/year-long-alarm/* "$diststart/747250/dist/"

cp -rfv assets/resistance-element/* "$diststart/1054600/dist/"

cp -rfv assets/downfall/* "$diststart/587650/dist/"

cp -rfv assets/prospekt/* "$diststart/399120/dist/"

cp -rfv assets/fast-detect/* "$diststart/353220/dist/"

cp -rfv assets/entropy-zero2/* "$diststart/1583720/dist/"
cp -rfv vpk "$diststart/1583720/dist/"
