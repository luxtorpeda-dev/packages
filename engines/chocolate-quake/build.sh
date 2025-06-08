#!/bin/bash

# CLONE PHASE
git clone https://github.com/Henrique194/chocolate-quake.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake ..
cmake --build .
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/chocolate-quake/share/quake/id1"
mkdir -p "$diststart/common/dist/chocolate-quake/share/quake/rogue"
mkdir -p "$diststart/common/dist/chocolate-quake/share/quake/hipnotic"

cp -v source/build/src/chocolate-quake "$diststart/common/dist/chocolate-quake/"
cp -v assets/chocolate-quake.sh "$diststart/common/dist/chocolate-quake/"

ln -s "../../../../id1/PAK0.PAK" "$diststart/common/dist/chocolate-quake/share/quake/id1/pak0.pak"
ln -s "../../../../id1/PAK1.PAK" "$diststart/common/dist/chocolate-quake/share/quake/id1/pak1.pak"
ln -s "../../../../rogue/pak0.pak" "$diststart/common/dist/chocolate-quake/share/quake/rogue/pak0.pak"
ln -s "../../../../hipnotic/pak0.pak" "$diststart/common/dist/chocolate-quake/share/quake/hipnotic/pak0.pak"
