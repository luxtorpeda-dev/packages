#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/yquake2 - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/yquake2/yquake2.git source
pushd source
git checkout "$COMMIT_HASH"
popd

git clone https://github.com/yquake2/ctf.git source-ctf
pushd source-ctf
git checkout 72b78e3
popd

git clone https://github.com/yquake2/xatrix.git source-xatrix
pushd source-xatrix
git checkout 2e2fac5
popd

git clone https://github.com/yquake2/rogue.git source-rogue
pushd source-rogue
git checkout 397fdd7
popd

git clone https://github.com/gabomdq/SDL_GameControllerDB.git sdl_gamecontrollerdb
pushd sdl_gamecontrollerdb
git checkout aa79a9b
popd

# BUILD PHASE
pushd "source"
echo 'release/q2ded : LDFLAGS += -l:librt.a' > config.mk
make -j "$(nproc)"
popd

pushd "source-ctf"
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j "$(nproc)"
popd

pushd "source-xatrix"
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j "$(nproc)"
popd

pushd "source-rogue"
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/baseq2"
mkdir -p "$diststart/common/dist/ctf"
mkdir -p "$diststart/common/dist/rogue"
mkdir -p "$diststart/common/dist/xatrix"

cp -v assets/quake2.sh "$diststart/common/dist/"
cp -v assets/default.lux.cfg "$diststart/common/dist/baseq2/yq2.cfg"
cp -v assets/default.lux.cfg "$diststart/common/dist/ctf/yq2.cfg"
cp -v assets/default.lux.cfg "$diststart/common/dist/rogue/yq2.cfg"
cp -v assets/default.lux.cfg "$diststart/common/dist/xatrix/yq2.cfg"
cp -v source/stuff/icon/Quake2.svg "$diststart/common/dist/"
cp -v sdl_gamecontrollerdb/gamecontrollerdb.txt "$diststart/common/dist/"

cp -rfv "source/release/"* "$diststart/common/dist/"
cp -rfv "source-ctf/build/Release/game.so" "$diststart/common/dist/ctf"
cp -rfv "source-rogue/build/Release/game.so" "$diststart/common/dist/rogue"
cp -rfv "source-xatrix/build/Release/game.so" "$diststart/common/dist/xatrix"
