#!/bin/bash

# CLONE PHASE
git clone https://gitlab.com/m210/BuildGDX.git source
pushd source
git checkout 74f585da4bdad28a6b68b15bc310d24fc71dca50
popd

# COPY PHASE

cp -rfv assets/* "$diststart/common/dist/"
