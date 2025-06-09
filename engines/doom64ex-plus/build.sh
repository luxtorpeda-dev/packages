#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information
# CLONE PHASE
git clone https://git.sr.ht/~marcin-serwin/Doom64EX-Minus source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd "source"
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/doom64ex-minus "$diststart/1148590/dist/"
cp -rfv assets/* "$diststart/1148590/dist/"

cp -rfv source/doomsnd.sf2 "$diststart/1148590/dist/"
cp -rfv source/doom64ex-minus.wad "$diststart/1148590/dist/"
