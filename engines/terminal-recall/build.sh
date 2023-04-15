#!/bin/bash

# CLONE PHASE
git clone https://github.com/jtrfp/terminal-recall.git source
pushd source
git checkout b502d01
popd

# BUILD PHASE
pushd "source"
mvn clean install
popd

# COPY PHASE
cp -rfv source/target/RunMe.jar "$diststart/358370/dist/"
cp -rfv source/target/lib "$diststart/358370/dist/"
cp -rfv assets/* "$diststart/358370/dist/"
