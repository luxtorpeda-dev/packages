#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/yquake2 - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/yquake2/yquake2.git source
pushd source
git checkout d08cf04
popd

# BUILD PHASE
pushd "source"
echo 'release/q2ded : LDFLAGS += -l:librt.a' > config.mk
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/baseq2"

cp -v assets/quake2.sh "$diststart/common/dist/"
cp -v assets/default.lux.cfg "$diststart/common/dist/baseq2/yq2.cfg"
cp -v source/stuff/icon/Quake2.svg "$diststart/common/dist/"
cp -rfv "source/release/"* "$diststart/common/dist/"
