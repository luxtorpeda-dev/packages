#!/bin/bash

# CLONE PHASE
git clone https://github.com/ValveSoftware/source-sdk-2013 source
pushd source
git checkout -f 0d8dcee
popd

# COPY PHASE
cp -rfv assets/entropy-zero/* "$diststart/714070/dist/"

cp -rfv assets/metastasis/* "$diststart/235780/dist/"

cp -rfv assets/year-long-alarm/* "$diststart/747250/dist/"
