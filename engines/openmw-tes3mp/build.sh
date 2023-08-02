#!/bin/bash

# CLONE PHASE
git clone https://github.com/TES3MP/openmw-tes3mp.git source
pushd source
git checkout -f 6895409
popd

# COPY PHASE
cp "assets/tes3mp-launcher.sh" "$diststart/22320/dist/"
