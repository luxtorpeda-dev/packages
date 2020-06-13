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
for app_id in $STEAM_APP_ID_LIST ; do
    mkdir -p "$diststart/$app_id/dist/baseq2"
    cp -v assets/quake2.sh "$diststart/$app_id/dist/"
    cp -v assets/default.lux.cfg "$diststart/$app_id/dist/"
    cp -v source/stuff/icon/Quake2.svg "$diststart/$app_id/dist/"
    cp -rfv "source/release/"* "$diststart/$app_id/dist/"
done
