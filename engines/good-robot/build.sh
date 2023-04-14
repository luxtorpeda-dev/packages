#!/bin/bash

# CLONE PHASE
git clone https://github.com/arvindrajayadav/Good-Robot.git source
pushd source
git checkout c9a0a5f
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build || exit 1
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBOOST_ROOT="$boostlocation" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/good_robot "$diststart/358830/dist/"
cp -rfv assets/run-good-robot.sh "$diststart/358830/dist/"

cp -rfv source/steamworks/redistributable_bin/linux64/libsteam_api.so "$diststart/358830/dist/lib"
