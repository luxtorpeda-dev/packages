#!/bin/bash

# CLONE PHASE
git clone https://github.com/arvindrajayadav/Good-Robot.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build || exit 1
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$VCPKG_INSTALLED_PATH" \
    -DBOOST_ROOT="$VCPKG_INSTALLED_PATH" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/good_robot "$diststart/358830/dist/"
cp -rfv assets/run-good-robot.sh "$diststart/358830/dist/"
cp -rfv source/steamworks/redistributable_bin/linux64/libsteam_api.so "$diststart/358830/dist/lib"
