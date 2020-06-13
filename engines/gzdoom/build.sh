#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/coelckers/gzdoom.git source
pushd source
git checkout f586196
git am < ../patches/0001-Workaround-for-missing-PRId64.patch
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
for app_id in $STEAM_APP_ID_LIST ; do
    cp -rfv "source/build"/{gzdoom,soundfonts,*.pk3} "$diststart/$app_id/dist/"
done
