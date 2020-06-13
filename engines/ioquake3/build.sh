#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/ioq3 - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/ioquake/ioq3.git source
pushd source
git checkout f2c61c1
popd

# BUILD PHASE
pushd "source"
make -j "$(nproc)"
popd

# COPY PHASE
for app_id in $STEAM_APP_ID_LIST ; do
    COPYDIR="../$app_id/dist" make --directory="source" copyfiles
done
