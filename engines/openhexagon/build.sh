#!/bin/bash

# CLONE PHASE
git clone https://github.com/SuperV1234/SSVOpenHexagon.git source
pushd source
git checkout 4285d30de43f380199cee03fc446eb5910c3ec0c
git submodule update --init --recursive
popd

git clone https://github.com/g-truc/glm glm
pushd glm
git checkout -f 947527d3
git submodule update --init --recursive
popd

# BUILD PHASE

pushd "source"
./build.sh
popd


# COPY PHASE
cp -rfv source/_RELEASE/SSVOpenHexagon "$diststart/1358090/dist/"
cp -rfv source/_RELEASE/HWorkshopUploader "$diststart/1358090/dist/"
