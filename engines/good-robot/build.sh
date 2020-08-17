#!/bin/bash

# CLONE PHASE
git clone https://github.com/arvindrajayadav/Good-Robot.git source
pushd source
git checkout c9a0a5f
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f a7090e8
git submodule update --init --recursive
popd

git clone https://github.com/DentonW/DevIL.git devil
pushd devil
git checkout -f a2d9193
popd

git clone https://github.com/vancegroup/freealut.git freealut
pushd freealut
git checkout -f 570dea5
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE

readonly boostlocation="$PWD/boost"
pushd "boost"
./bootstrap.sh
./b2 headers
./b2  --with-program_options --with-filesystem --with-system
popd

pushd "devil/DevIL"
mkdir build
cd build || exit 1
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd "freealut"
mkdir build
cd build || exit 1
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

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
mkdir -p "$diststart/358830/dist/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/358830/dist/lib"
cp -rfv source/build/good_robot "$diststart/358830/dist/"
cp -rfv assets/run-good-robot.sh "$diststart/358830/dist/"
cp -rfv boost/stage/lib/*.so* "$diststart/358830/dist/lib"
cp -rfv source/steamworks/redistributable_bin/linux64/libsteam_api.so "$diststart/358830/dist/lib"
